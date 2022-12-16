//
//  LoginPresenter.swift
//  vkClient
//
//  Created by Lina Prosvetova on 22.11.2022.
//

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
    
    func getTokenFrom(urlFragment: String) {
        let params = urlFragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") } .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        let token = params["access_token"]
        guard token != nil else { return }
        Session.shared.token = token ?? " "
        guard let vc = view as? LoginViewController else { return }
        authPageLoaded(vc: vc)
    }
}
