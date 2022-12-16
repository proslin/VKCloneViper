//
//  FriendPhotoViewController.swift
//  vkClient
//
//  Created by Lina Prosvetova on 25.11.2022.
//

import UIKit

final class FriendPhotoViewController: UIViewController {
    var output: FriendPhotoViewControllerOutput?
    
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
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(width: view.bounds.width, padding: VKDimensions.padding))
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.refreshControl = refreshControl
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UINib(nibName: String(describing: FriendPhotoCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: FriendPhotoCell.self))
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
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
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            navBarContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBarContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBarContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBarContainer.heightAnchor.constraint(equalToConstant: 44.0),
            
            collectionView.topAnchor.constraint(equalTo: navBarContainer.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func refresh(sender: UIRefreshControl) {
        output?.refreshDragged()
    }
}

// MARK: - FriendPhotoViewControllerInput
extension FriendPhotoViewController: FriendPhotoViewControllerInput {
    
    func setupNavigationBar(model: NavigationBarProtocol) {
        let _ = NavigationBarCustom.instanceFromNib(model: model, parentView: navBarContainer)
    }
    
    func initData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func updateData(deletions: [Int], insertions: [Int], modifications: [Int]) {
        DispatchQueue.main.async {
            self.collectionView.performBatchUpdates({ self.collectionView.insertItems(at: insertions.map({ IndexPath(row: $0, section: 0) }))
                self.collectionView.deleteItems(at: deletions.map({ IndexPath(row: $0, section: 0)}))
                self.collectionView.reloadItems(at: modifications.map({ IndexPath(row: $0, section: 0) })) }, completion: nil)
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
}

// MARK: UICollectionViewDataSource
extension FriendPhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        output?.getPhotosCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FriendPhotoCell.self), for: indexPath) as? FriendPhotoCell,
           let photo = output?.getPhotoFor(row: indexPath.row) {
            cell.set(photo: photo)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

// MARK: UICollectionViewDelegate
extension FriendPhotoViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        output?.getMorePhoto(row: indexPath.row)
    }
}

