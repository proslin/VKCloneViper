//
//  UserGroupsInteractor.swift
//  vkClient
//
//  Created by Lina Prosvetova on 24.11.2022.
//

import Foundation
import RealmSwift

final class UserGroupsInteractor {
    var output: UserGroupsInteractorOutput?
    var token: NotificationToken?
    var groups: Results<GroupModel>?
    
    
    // MARK: Private methods
    private func getGroupsFromNetwork() {
        NetworkService.shared.getGroups { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let groups):
                DispatchQueue.main.async {
                    if let error = RealmService.shared.saveGroups(groups) {
                        self.output?.dataBaseFail(error)
                    } else {
                        guard let groupsFromRealm = RealmService.shared.loadGroups() else { return }
                        self.groups = groupsFromRealm
                        self.output?.getGroupsSuccess(Array(groupsFromRealm))
                        self.startObserving()
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.output?.getGroupsFail(error)
                }
            }
        }
    }
    
    private func getGroupsFromRealm() {
        self.groups = RealmService.shared.loadGroups()
        guard let groups = groups, !groups.isEmpty else {
            output?.getGroupsFail(.invalidData)
            return
        }
        output?.getGroupsSuccess(Array(groups))
        startObserving()
    }
    
    private func addGroupToServer(_ group: GroupModel) {
        NetworkService.shared.addGroup(for: group.groupId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                if result.response == 1 {
                    DispatchQueue.main.async {
                        if let error = RealmService.shared.addGroup(group: group) {
                            self.output?.dataBaseFail(error)
                        } else {
                            guard let groupsFromRealm = RealmService.shared.loadGroups() else { return }
                            self.output?.groupAddedSuccess(Array(groupsFromRealm), group)
                        }
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.output?.getGroupsFail(error)
                }
            }
        }
    }
    
    func deleteGroupFromServer(_ group: GroupModel) {
        NetworkService.shared.deleteGroup(for: group.groupId) { result in
            switch result {
            case .success(let result):
                if result.response == 1 {
                    DispatchQueue.main.async {
                        if let error = RealmService.shared.deleteGroup(groupId: group.groupId) {
                            self.output?.dataBaseFail(error)
                        } else {
                            guard let groupsFromRealm = RealmService.shared.loadGroups() else { return }
                            self.output?.groupDeletedSucces(Array(groupsFromRealm))
                        }
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.output?.getGroupsFail(error)
                }
            }
        }
    }
}

extension UserGroupsInteractor: UserGroupsInteractorInput {
    func getUpdatedGroups() {
        getGroupsFromNetwork()
    }
    
    func getGroupsInitial() {
        switch UserSettings.entryCount - 1 {
        case 1:
            getGroupsFromNetwork()
        case 2..<5:
            getGroupsFromRealm()
        default:
            getGroupsFromNetwork()
        }
    }
    
    func startObserving() {
        token = groups?.observe { [weak self] changes in
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
    
    func addGroup(_ group: GroupModel) {
        addGroupToServer(group)
    }
    
    func deleteGroup(_ group: GroupModel) {
        deleteGroupFromServer(group)
    }
}
