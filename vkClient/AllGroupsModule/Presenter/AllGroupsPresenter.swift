//
//  AllGroupsPresenter.swift
//  vkClient
//
//  Created by Lina Prosvetova on 28.11.2022.
//

import Foundation

final class AllGroupsPresenter {
    weak var view: AllGroupsViewControllerInput?
    var interactor: AllGroupsInteractorInput!
    var output: AllGroupsModuleOutput!
    
    private var groups: Array<GroupModel> = []
    private var timer: Timer?
}

extension AllGroupsPresenter: AllGroupsViewControllerOutput {
    func viewIsReady() {
        let navBarButtonModel = NavBarButton(image: SFSymbols.shevron, action: { [weak self] in
            self?.view?.navigationController?.popViewController(animated: true)
        })
        let navBarModel = NavigationBarModel(title: "", leftButton: navBarButtonModel, isSearchBar: true, searchBarPlaceholder: "введите сообщество")
        view?.setupNavigationBar(model: navBarModel)
        view?.navigationController?.navigationBar.isHidden = true
    }
    
    func getGroupsCount() -> Int {
        groups.count
    }
    
    func getGroupFor(row: Int) -> GroupModel {
        groups[row]
    }
    
    func tapCellWith(index: Int) {
        let selectedGroup = groups[index]
        output.tapGroup(selectedGroup)
    }
    
    func searchStarted(search: String) {
        interactor.getSearchesGroup(for: search)
    }
    
    func removeGroupsFromArray() {
        self.groups.removeAll()
    }
}

extension AllGroupsPresenter: AllGroupsInteractorOutput {
    func initializedData() {
        view?.initData()
    }
    
    func getSearchedGroupsSuccess(_ groups: [GroupModel]) {
        self.groups = groups
        view?.initData()
    }
    
    func getSearchedGroupsFail(_ error: ErrorMessage) {
        view?.showAlert(title: "Что-то пошло не так", msg: error.rawValue)
    }
    
    func createTimer(searchText: String) {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false) { timer in
                timer.invalidate()
                self.searchStarted(search: searchText)
            }
        }
    }
    
    func cancelTimer() {
        timer?.invalidate()
        timer = nil
    }
}

