//
//  LoginRouter.swift
//  vkClient
//
//  Created by Lina Prosvetova on 24.11.2022.
//

import Foundation
import UIKit

final class LoginRouter {
    
}

extension LoginRouter: LoginRouterInput {
    func showTabBar(from vc: UIViewController) {
        let tabBarVC = TabBarViewController()
        tabBarVC.modalPresentationStyle = .fullScreen
        tabBarVC.navigationController?.navigationBar.isHidden = true
        vc.present(tabBarVC, animated: false)
    }
}
