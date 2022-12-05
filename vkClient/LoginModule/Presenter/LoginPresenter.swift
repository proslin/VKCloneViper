//
//  LoginPresenter.swift
//  vkClient
//
//  Created by Lina Prosvetova on 22.11.2022.
//

import Foundation
import UIKit

final class LoginPresenter {
    weak var view: LoginViewControllerInput?
    var interactor: LoginInteractorInput!
    var router: LoginRouterInput!
}

extension LoginPresenter: LoginViewControllerIOutput {
    func viewIsReady() {
        view?.loadURLRequest(interactor.getVKURLRequest())
    }
    
    func authPageLoaded(vc: UIViewController) {
        router.showTabBar(from: vc)
    }
}
