//
//  FriendsInteractorInput.swift
//  vkClient
//
//  Created by Lina Prosvetova on 19.11.2022.
//

import Foundation

protocol FriendsInteractorInput {
    var output: FriendsInteractorOutput? { get set }
    
    func getFriends()
    func startObserving()
}
