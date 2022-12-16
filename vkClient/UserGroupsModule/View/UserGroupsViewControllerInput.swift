//
//  UserGroupsViewControllerInput.swift
//  vkClient
//
//  Created by Lina Prosvetova on 24.11.2022.
//

import Foundation
import RealmSwift

protocol UserGroupsViewControllerInput: Presentable {
    var output: UserGroupsViewControllerOutput? { get set }
    
    func setupNavigationBar(model: NavigationBarProtocol)
    func initData()
    func updateData(deletions: [Int], insertions: [Int], modifications: [Int])
    func showLoader()
    func removeLoader()
    func showAlert(title: String, msg: String)
    func getVC() -> UIViewController?
}
