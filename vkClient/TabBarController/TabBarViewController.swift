//
//  TabBarViewController.swift
//  vkClient
//
//  Created by Lina Prosvetova on 23.11.2022.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [createFriendsNC(), createGroupsNC()]
        UITabBar.appearance().tintColor = .systemBlue
        UITabBar.appearance().backgroundColor = .systemBackground
    }
    
    func createFriendsNC() -> UINavigationController {
        let friendsModule = FriendsModule()
        if let friendsVC = friendsModule.getVC() {
            friendsVC.tabBarItem = UITabBarItem(title: "Друзья", image: UIImage(systemName: SFSymbols.friends), tag: 0)
            return UINavigationController(rootViewController: friendsVC)
        }
        return UINavigationController()
    }
    
    func createGroupsNC() -> UINavigationController {
        let groupsModule = UserGroupsModule()
        if let groupsVC = groupsModule.getVC() {
            groupsVC.tabBarItem = UITabBarItem(title: "Группы", image: UIImage(systemName: SFSymbols.groups), tag: 1)
            return UINavigationController(rootViewController: groupsVC)
        }
        return UINavigationController()
    }
    
    func openTabBar() {
        let tabBarVC = TabBarViewController()
        tabBarVC.modalPresentationStyle = .fullScreen
        tabBarVC.navigationController?.navigationBar.isHidden = true
        present(tabBarVC, animated: false, completion: nil)
    }
}



