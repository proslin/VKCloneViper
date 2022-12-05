//
//  FriendsVCInput.swift
//  vkClient
//
//  Created by Lina Prosvetova on 19.11.2022.
//

import Foundation
import RealmSwift

protocol FriendsViewControllerInput: UIViewController {
    var output: FriendsViewControllerOutput? { get set }
    
    func setupNavigationBar(model: NavigationBarProtocol)
    func initData()
    func updateData(deletions: [Int], insertions: [Int], modifications: [Int])
    func showLoader()
    func removeLoader()
    func showAlert(title: String, msg: String)
    func getVC() -> UIViewController?
}
