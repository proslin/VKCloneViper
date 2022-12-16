//
//  FriendPhotoViewControllerInput.swift
//  vkClient
//
//  Created by Lina Prosvetova on 21.11.2022.
//

import Foundation
import RealmSwift

protocol FriendPhotoViewControllerInput: Presentable {
    var output: FriendPhotoViewControllerOutput? { get set }
    
    func setupNavigationBar(model: NavigationBarProtocol)
    func initData()
    func updateData(deletions: [Int], insertions: [Int], modifications: [Int])
    func showLoader()
    func removeLoader()
    func showAlert(title: String, msg: String)
}
