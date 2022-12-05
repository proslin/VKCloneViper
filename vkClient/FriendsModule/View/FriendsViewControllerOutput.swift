//
//  FriendsVCOutput.swift
//  vkClient
//
//  Created by Lina Prosvetova on 19.11.2022.
//

import Foundation

protocol FriendsViewControllerOutput {
    func viewIsReady()
    func getFriendsCount() -> Int
    func getFriendFor(row: Int) -> FriendModel
    func tapCellWith(index: Int)
    func refreshDragged()
}
