//
//  FriendsInteractorOutput.swift
//  vkClient
//
//  Created by Lina Prosvetova on 19.11.2022.
//

import Foundation

protocol FriendsInteractorOutput {
    func initializedData()
    func updatedData(deletions: [Int], insertions: [Int], modifications: [Int])
    func getDataFail(_ error: Error)
    
    func getFriendsSuccess (_ friends: [FriendModel])
    func getFriendsFail(_ error: ErrorMessage)
    func dataBaseFail(_ error: Error)
}
