//
//  AllGroupsInteractorOutput.swift
//  vkClient
//
//  Created by Lina Prosvetova on 28.11.2022.
//

import Foundation

protocol AllGroupsInteractorOutput {
    func initializedData()
    func getSearchedGroupsSuccess(_ groups: [GroupModel])
    func getSearchedGroupsFail(_ error: ErrorMessage)
}
