//
//  AllGroupsViewController.swift
//  vkClient
//
//  Created by Lina Prosvetova on 24.11.2022.
//

import UIKit

final class AllGroupsViewController: UIViewController {
    var output: AllGroupsViewControllerOutput?
    
    private let navBarContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UINib(nibName: String(describing: AllGroupCell.self), bundle: nil), forCellReuseIdentifier: String(describing: AllGroupCell.self))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layoutViews()
        output?.viewIsReady()

    }
    
    // MARK: - Private methods
    private func layoutViews() {
        view.addSubview(navBarContainer)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            navBarContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBarContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBarContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBarContainer.heightAnchor.constraint(equalToConstant: 44.0),
            
            tableView.topAnchor.constraint(equalTo: navBarContainer.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - AllGroupsViewControllerInput
extension AllGroupsViewController: AllGroupsViewControllerInput {
    func setupNavigationBar(model: NavigationBarProtocol) {
        let navBar = NavigationBarCustom.instanceFromNib(model: model, parentView: navBarContainer)
        navBar?.searchBar.delegate = self
    }
    
    func initData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showAlert(title: String, msg: String) {
        DispatchQueue.main.async {
            self.presentAlertVC(title: title, message: msg)
        }
    }
}

// MARK: - UITableViewDataSource
extension AllGroupsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output?.getGroupsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AllGroupCell.self)) as? AllGroupCell,
        let group = output?.getGroupFor(row: indexPath.row) {
            cell.set(group: group)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
}

// MARK: - UITableViewDelegate
extension AllGroupsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.tapCellWith(index: indexPath.row)
    }
}

// MARK: - UISearchBarDelegate
extension AllGroupsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty && searchText.count > 1 {
            output?.cancelTimer()
            output?.createTimer(searchText: searchText)
        } else {
            output?.removeGroupsFromArray()
            self.tableView.reloadData()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        output?.removeGroupsFromArray()
        self.tableView.reloadData()
    }
}

