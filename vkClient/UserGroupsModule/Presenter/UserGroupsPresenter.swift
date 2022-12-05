//
//  UserGroupsPresenter.swift
//  vkClient
//
//  Created by Lina Prosvetova on 24.11.2022.
//

import Foundation

final class UserGroupsPresenter {
    weak var view: UserGroupsViewControllerInput?
    var interactor: UserGroupsInteractorInput!
    var router: UserGroupsRouterInput!
    
    var groups: Array<GroupModel> = []
}

// MARK: - UserGroupsViewControllerOutput
extension UserGroupsPresenter: UserGroupsViewControllerOutput {
    
    func viewIsReady() {
        view?.showLoader()
        let navBarButtonModel = NavBarButton(image: SFSymbols.plus, action: { [weak self] in
            guard let self = self else { return }
            self.router.showGroupSearch(from: self.view?.getVC(), output: self)
        })
        let navBarModel = NavigationBarModel(title: "Группы", rightButton: navBarButtonModel)
        view?.setupNavigationBar(model: navBarModel)
        view?.navigationController?.navigationBar.isHidden = true

        interactor.getGroupsInitial()
    }
    
    func getGroupsCount() -> Int {
        groups.count
    }
    
    func getGroupFor(row: Int) -> GroupModel {
        groups[row]
    }

    func refreshDragged() {
        interactor.getUpdatedGroups()
    }
    
    func addGroup(group: GroupModel) {
        interactor.addGroup(group)
    }
    
    func deleteGroup(index: Int) {
        let group = groups[index]
        interactor.deleteGroup(group)
    }
}

extension UserGroupsPresenter: UserGroupsInteractorOutput {
    
    func initializedData() {
        view?.initData()
    }
    
    func updatedData(deletions: [Int], insertions: [Int], modifications: [Int]) {
        view?.updateData(deletions: deletions, insertions: insertions, modifications: modifications)
    }
    
    func getDataFail(_ error: Error) {
        view?.showAlert(title: "Что-то пошло не так", msg: error.localizedDescription)
    }
    
    func getGroupsSuccess(_ groups: [GroupModel]) {
        self.groups = groups
        view?.initData()
        view?.removeLoader()
    }
    
    func groupAddedSuccess(_ groups: [GroupModel], _ group: GroupModel) {
        self.groups = groups
        view?.showAlert(title: "Готово", msg: "Вы вступили в группу \(group.groupName)")
    }
    
    func groupDeletedSucces(_ groups: [GroupModel]) {
        self.groups = groups
        
    }
    
    func getGroupsFail(_ error: ErrorMessage) {
        view?.showAlert(title: "Что-то пошло не так", msg: error.rawValue)
        view?.removeLoader()
    }
    
    func dataBaseFail(_ error: Error) {
        view?.showAlert(title: "Ошибка базы данных", msg: error.localizedDescription)
        view?.removeLoader()
    }
}

extension UserGroupsPresenter: AllGroupsModuleOutput {
    func tapGroup(_ group: GroupModel) {
        addGroup(group: group)
    }
}

