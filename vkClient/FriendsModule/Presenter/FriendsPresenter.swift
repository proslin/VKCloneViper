//
//  FriendsPresenter.swift
//  vkClient
//
//  Created by Lina Prosvetova on 19.11.2022.
//

import UIKit

final class FriendsPresenter {
    weak var view: FriendsViewControllerInput?
    var interactor: FriendsInteractorInput!
    var router: FriendsRouterInput!
    
    private var friends: Array<FriendModel> = []
}

extension FriendsPresenter {
    func present(from vc: UIViewController) {
        view?.present(from: vc)
    }
}

// MARK: - FriendsVCOutput
extension FriendsPresenter: FriendsViewControllerOutput {
    func viewIsReady() {
        view?.showLoader()
        let navBarModel = NavigationBarModel(title: "Друзья")
        view?.setupNavigationBar(model: navBarModel)
        view?.viewController.navigationController?.navigationBar.isHidden = true
        
        interactor.getFriends()
        interactor.startObserving()
    }
    
    func getFriendsCount() -> Int {
        friends.count
    }
    
    func getFriendFor(row: Int) -> FriendModel {
        friends[row]
    }
    
    func tapCellWith(index: Int) {
      let friend = friends[index]
        router.showFriendPhotos(friendId: friend.friendId, from: view?.getVC())
        
    }
    
    func refreshDragged() {
        interactor.getFriends()
    }
}

// MARK: - FriendsInteractorOutput
extension FriendsPresenter: FriendsInteractorOutput {
    
    func initializedData() {
        view?.initData()
    }
    
    func updatedData(deletions: [Int], insertions: [Int], modifications: [Int]) {
        view?.updateData(deletions: deletions, insertions: insertions, modifications: modifications)
    }
    
    func getDataFail(_ error: Error) {
        view?.showAlert(title: "Что-то пошло не так", msg: error.localizedDescription)
    }
    
    func getFriendsSuccess(_ friends: [FriendModel]) {
        self.friends = friends
        view?.initData()
        view?.removeLoader()
    }
    
    func getFriendsFail(_ error: ErrorMessage) {
        view?.showAlert(title: "Что-то пошло не так", msg: error.rawValue)
        view?.removeLoader()
    }
    
    func dataBaseFail(_ error: Error) {
        view?.showAlert(title: "Ошибка базы данных", msg: error.localizedDescription)
        view?.removeLoader()
    }
}
