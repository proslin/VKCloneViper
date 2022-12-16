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
    
    init() {
        view = FriendsViewController()
        let interactor = FriendsInteractor()
        
        presenter = FriendsPresenter()
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = FriendsRouter()
        
        view?.output = presenter
        interactor.output = presenter
    }
    
    public func getVC() -> UIViewController? {
        view?.viewController
    }
}

extension FriendsModule: ModulePresentable {
    func present(from viewController: UIViewController) {
        presenter.present(from: viewController)
    }
}
