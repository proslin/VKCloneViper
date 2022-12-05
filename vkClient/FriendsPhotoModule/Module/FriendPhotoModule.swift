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
    
    public let vc: FriendPhotoViewController
    
    init(selectedFriendId: Int) {
        vc = FriendPhotoViewController()
        view = vc
        let interactor = FriendPhotoInteractor()
        
        presenter = FriendPhotoPresenter()
        presenter.view = vc
        presenter.interactor = interactor
        presenter.selectedFriendID = selectedFriendId
        
        view?.output = presenter
        interactor.output = presenter
    }
    
    public func getVC() -> UIViewController {
        vc
    }
    
    public func presentModule(from vc: UIViewController) {
        guard let view = view else { return }
        vc.show(view, sender: nil)
    }
}
