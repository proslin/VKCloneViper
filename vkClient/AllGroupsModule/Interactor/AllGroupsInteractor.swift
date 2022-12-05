//
//  AllGroupsInteractor.swift
//  vkClient
//
//  Created by Lina Prosvetova on 28.11.2022.
//

import Foundation

final class AllGroupsInteractor {
    var output: AllGroupsInteractorOutput?
    var groups: Array<GroupModel>?
    
    private func getSearchedGroupsFromNetwork(searchRequest: String) {
        NetworkService.shared.getSearchGroups(for: searchRequest) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let groups):
                var ids = groups.reduce("") { $0 + String($1.groupId) + "," }
                if !ids.isEmpty {
                    ids.removeLast(1)
                    self.getGroupsList(groupsIds: ids)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.output?.getSearchedGroupsFail(error)
                }
            }
        }
    }
    
    private func getGroupsList(groupsIds: String) {
        NetworkService.shared.getGroupsList(for: groupsIds) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let groups):
                self.groups = groups
                self.output?.getSearchedGroupsSuccess(groups)
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.output?.getSearchedGroupsFail(error)
                }
            }
        }
    }
}

extension AllGroupsInteractor: AllGroupsInteractorInput {
    func getSearchesGroup(for searchRequest: String) {
        getSearchedGroupsFromNetwork(searchRequest: searchRequest)
    }
}
