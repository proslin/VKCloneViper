//
//  LoginModule.swift
//  vkClient
//
//  Created by Lina Prosvetova on 22.11.2022.
//

import UIKit

final class LoginModule {
    private let view: LoginViewControllerInput?
    private var presenter: LoginPresenter
    
    init () {
        view = LoginViewController()
        let interactor = LoginInteractor()
        
        presenter = LoginPresenter()
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = LoginRouter()
        
        view?.output = presenter
    }
    
    public func getVC() -> UIViewController? {
        view?.viewController
    }
}
