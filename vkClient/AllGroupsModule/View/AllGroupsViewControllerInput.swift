//
//  AllGroupsViewControllerInput.swift
//  vkClient
//
//  Created by Lina Prosvetova on 28.11.2022.
//

import Foundation
import UIKit

protocol AllGroupsViewControllerInput: Presentable {
    var output: AllGroupsViewControllerOutput? { get set }
    
    func setupNavigationBar(model: NavigationBarProtocol)
    func initData()
    func showAlert(title: String, msg: String)
}
