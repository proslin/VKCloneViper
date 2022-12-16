//
//  FriendPhotoModule.swift
//  vkClient
//
//  Created by Lina Prosvetova on 23.11.2022.
//

import UIKit

final class FriendPhotoModule {
    private let view: FriendPhotoViewControllerInput?
    private let presenter: FriendPhotoPresenter
    
    init(selectedFriendId: Int) {
        view = FriendPhotoViewController()
        let interactor = FriendPhotoInteractor()
        
        presenter = FriendPhotoPresenter()
        presenter.view = view
        presenter.interactor = interactor
        presenter.selectedFriendID = selectedFriendId
        
        view?.output = presenter
        interactor.output = presenter
    }
}

extension FriendPhotoModule: ModulePresentable {
    func present(from viewController: UIViewController) {
        presenter.present(from: viewController)
    }
}
