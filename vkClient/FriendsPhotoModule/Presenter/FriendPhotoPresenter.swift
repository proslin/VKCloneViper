//
//  FriendPhotoPresenter.swift
//  vkClient
//
//  Created by Lina Prosvetova on 23.11.2022.
//

import UIKit

final class FriendPhotoPresenter {
    weak var view: FriendPhotoViewControllerInput?
    var interactor: FriendPhotoInteractorInput!
    
    private var photos: Array<PhotoModel> = []
    private var offset: Int = 0
    private var allPhotosCount: Int = 0
    
    var selectedFriendID: Int = 0
}

extension FriendPhotoPresenter {
    func present(from vc: UIViewController) {
        view?.present(from: vc)
    }
}

// MARK: - FriendsVCOutput
extension FriendPhotoPresenter: FriendPhotoViewControllerOutput {
    func viewIsReady() {
        view?.showLoader()
        let navBarButtonModel = NavBarButton(image: SFSymbols.shevron, action: {
            self.view?.viewController.navigationController?.popViewController(animated: true)
        })
        let navBarModel = NavigationBarModel(title: "Фотографии", leftButton: navBarButtonModel)
        view?.setupNavigationBar(model: navBarModel)
        view?.viewController.navigationController?.navigationBar.isHidden = true
        
        interactor.getPhotos(for: selectedFriendID, offset: offset, isLoadingMorePhotos: false)
        interactor.startObserving()
    }
    
    func getPhotosCount() -> Int {
        photos.count
    }
    
    func getPhotoFor(row: Int) -> PhotoModel {
        photos[row]
    }
    
    func refreshDragged() {
        interactor.getPhotos(for: selectedFriendID, offset: offset, isLoadingMorePhotos: false)
    }
    
    func getSelectedModel(selectedFriendID: Int) {
        self.selectedFriendID = selectedFriendID
    }
    
    func getMorePhoto(row: Int) {
        let photosCount = getPhotosCount()
        if offset < allPhotosCount  && allPhotosCount > (200 + offset) && row == photosCount - 1 {
            offset += 200
            interactor.getPhotos(for: selectedFriendID, offset: offset, isLoadingMorePhotos: true)
        }
    }
}

extension FriendPhotoPresenter: FriendPhotoInteractorOutput  {
    func initializedData() {
        view?.initData()
    }
    
    func updatedData(deletions: [Int], insertions: [Int], modifications: [Int]) {
        view?.updateData(deletions: deletions, insertions: insertions, modifications: modifications)
    }
    
    func getDataFail(_ error: Error) {
        view?.showAlert(title: "Что-то пошло не так", msg: error.localizedDescription)
    }
    
    func getPhotossSuccess(_ photos: [PhotoModel]) {
        self.photos.append(contentsOf: photos)
        view?.initData()
        view?.removeLoader()
    }
    
    func getPhotosFail(_ error: ErrorMessage) {
        view?.showAlert(title: "Что-то пошло не так", msg: error.rawValue)
        view?.removeLoader()
    }
    
    func getAllPhotosCount(allPhotosCount: Int) {
        self.allPhotosCount = allPhotosCount
    }
    
    func dataBaseFail(_ error: Error) {
        view?.showAlert(title: "Ошибка базы данных", msg: error.localizedDescription)
        view?.removeLoader()
    }    
}
