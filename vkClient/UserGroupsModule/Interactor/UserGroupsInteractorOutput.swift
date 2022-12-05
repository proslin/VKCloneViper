//
//  UserGroupsInteractorOutput.swift
//  vkClient
//
//  Created by Lina Prosvetova on 24.11.2022.
//

import Foundation

protocol UserGroupsInteractorOutput {
    func initializedData()
    func updatedData(deletions: [Int], insertions: [Int], modifications: [Int])
    func getDataFail(_ error: Error)
    
    func getGroupsSuccess (_ groups: [GroupModel])
    func getGroupsFail(_ error: ErrorMessage)
    func groupAddedSuccess(_ groups: [GroupModel], _ group: GroupModel)
    func groupDeletedSucces(_ groups: [GroupModel])
    func dataBaseFail(_ error: Error)
}
