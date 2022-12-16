//
//  UserGroupsModule.swift
//  vkClient
//
//  Created by Lina Prosvetova on 24.11.2022.
//

import UIKit

final class UserGroupsModule {
    private let view: UserGroupsViewControllerInput?
    private let presenter: UserGroupsPresenter
    
    init() {
        view = UserGroupsViewController()
        let interactor = UserGroupsInteractor()
        
        presenter = UserGroupsPresenter()
        presenter.view = view
        presenter.interactor = interactor
        
        presenter.router = UserGroupsRouter()
 
        view?.output = presenter
        interactor.output = presenter
    }
    
    public func getVC() -> UIViewController? {
        view?.viewController
    }
}

extension UserGroupsModule: ModulePresentable {
    func present(from viewController: UIViewController) {
        presenter.present(from: viewController)
    }
}
