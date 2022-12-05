//
//  AllGroupsViewControllerOutput.swift
//  vkClient
//
//  Created by Lina Prosvetova on 28.11.2022.
//

import Foundation

protocol AllGroupsViewControllerOutput {
    func viewIsReady()
    func getGroupsCount() -> Int
    func getGroupFor(row: Int) -> GroupModel
    func tapCellWith(index: Int)
    func searchStarted(search: String)
    func removeGroupsFromArray()
    func createTimer(searchText: String)
    func cancelTimer() 
}
