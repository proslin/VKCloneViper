//
//  LoginRouter.swift
//  vkClient
//
//  Created by Lina Prosvetova on 24.11.2022.
//

import UIKit

final class LoginRouter: LoginRouterInput  {
    func showTabBar(from vc: UIViewController) {
        let tabBarVC = TabBarViewController()
        tabBarVC.modalPresentationStyle = .fullScreen
        tabBarVC.navigationController?.navigationBar.isHidden = true
        vc.present(tabBarVC, animated: false)
    }
}
