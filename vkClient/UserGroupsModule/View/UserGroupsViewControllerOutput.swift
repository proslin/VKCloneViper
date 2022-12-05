//
//  UserGroupsViewControllerOutput.swift
//  vkClient
//
//  Created by Lina Prosvetova on 24.11.2022.
//

import Foundation

protocol UserGroupsViewControllerOutput {
    func viewIsReady()
    func getGroupsCount() -> Int
    func getGroupFor(row: Int) -> GroupModel
    func refreshDragged()
    func addGroup(group: GroupModel)
    func deleteGroup(index: Int)
}
