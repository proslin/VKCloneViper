//
//  UserGroupsInteractorInput.swift
//  vkClient
//
//  Created by Lina Prosvetova on 24.11.2022.
//

import Foundation

protocol UserGroupsInteractorInput {
    var output: UserGroupsInteractorOutput? { get set }
    
    func getGroupsInitial()
    func getUpdatedGroups()
    func startObserving()
    func addGroup(_ group: GroupModel)
    func deleteGroup(_ group: GroupModel)
}
