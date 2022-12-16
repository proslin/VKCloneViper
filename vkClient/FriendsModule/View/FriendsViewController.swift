//
//  FriendsVCv.swift
//  vkClient
//
//  Created by Lina Prosvetova on 21.11.2022.
//

import UIKit

final class FriendsViewController: UIViewController {
    var output: FriendsViewControllerOutput?
    
    private let navBarContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.refreshControl = refreshControl
        tableView.register(UINib(nibName: String(describing: FriendCell.self), bundle: nil), forCellReuseIdentifier: String(describing: FriendCell.self))
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
    
    @objc func refresh(sender: UIRefreshControl) {
        output?.refreshDragged()
    }
}

// MARK: - FriendsVCInput
extension FriendsViewController: FriendsViewControllerInput {
    func setupNavigationBar(model: NavigationBarProtocol) {
        let _ = NavigationBarCustom.instanceFromNib(model: model, parentView: navBarContainer)
    }
    
    func initData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func updateData(deletions: [Int], insertions: [Int], modifications: [Int]) {
        DispatchQueue.main.async {
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
            self.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0,   section: 0) }), with: .automatic)
            self.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
            self.tableView.endUpdates()
        }
    }
    
    func showLoader() {
            self.showSpinner()
    }
    
    func removeLoader() {
            self.removeSpinner()
    }
    
    func showAlert(title: String, msg: String) {
        DispatchQueue.main.async {
            self.presentAlertVC(title: title, message: msg)
        }
    }
    
    func getVC() -> UIViewController? {
        self
    }
}

// MARK: - UITableViewDataSource
extension FriendsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output?.getFriendsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FriendCell.self)) as? FriendCell,
           let friend = output?.getFriendFor(row: indexPath.row) {
            cell.set(friend: friend)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate
extension FriendsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.tapCellWith(index: indexPath.row)
    }
}
