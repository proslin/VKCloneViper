//
//  FriendsModule.swift
//  vkClient
//
//  Created by Lina Prosvetova on 20.11.2022.
//

import UIKit

final class FriendsModule {
    private let view: FriendsViewControllerInput?
    private let presenter: FriendsPresenter
    
    public let vc: FriendsViewController
    
    init() {
        vc = FriendsViewController()
        view = vc
        let interactor = FriendsInteractor()
        
        presenter = FriendsPresenter()
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = FriendsRouter()
        
        view?.output = presenter
        interactor.output = presenter
    }
    
    public func getVC() -> UIViewController {
        vc
    }
}
