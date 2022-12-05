//
//  FriendsInteractor.swift
//  vkClient
//
//  Created by Lina Prosvetova on 19.11.2022.
//

import Foundation
import RealmSwift

final class FriendsInteractor {
    var output: FriendsInteractorOutput?
    var token: NotificationToken?
    var friends: Results<FriendModel>?
    
    // MARK: Private methods
    private func getFriendsFromNetwork() {
        NetworkService.shared.getFriends() { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let friends):
                DispatchQueue.main.async {
                    if let error = RealmService.shared.saveFriends(friends) {
                        self.output?.dataBaseFail(error)
                    } else {
                        self.output?.getFriendsSuccess(friends)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.output?.getFriendsFail(error)
                }
            }
        }
    }
    
    private func getFriendsFromRealm() {
        self.friends = RealmService.shared.loadFriends()
        guard let friends = friends, !friends.isEmpty else {
            output?.getFriendsFail(.invalidData)
            return
        }
        output?.getFriendsSuccess(Array(friends))
    }
}

// MARK - FriendsInteractorInput
extension FriendsInteractor: FriendsInteractorInput {
    func startObserving() {
        token = friends?.observe { [weak self] changes in
            switch changes {
            case .initial:
                self?.output?.initializedData()
            case .update(_, let deletions, let insertions, let modifications):
                self?.output?.updatedData(deletions: deletions, insertions: insertions, modifications: modifications)
            case .error(let error):
                self?.output?.getDataFail(error)
            }
        }
    }
    
    func getFriends() {
        switch UserSettings.entryCount {
        case 1:
            getFriendsFromNetwork()
            UserSettings.entryCount += 1
        case 2..<5:
            getFriendsFromRealm()
            UserSettings.entryCount += 1
        case 5:
            getFriendsFromNetwork()
            UserSettings.entryCount = 1
        default:
            getFriendsFromNetwork()
        }
    }
}
