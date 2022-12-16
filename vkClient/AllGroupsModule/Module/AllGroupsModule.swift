//
//  AllGroupsModule.swift
//  vkClient
//
//  Created by Lina Prosvetova on 28.11.2022.
//

import UIKit

final class AllGroupsModule {
    private let view: AllGroupsViewControllerInput?
    private let presenter: AllGroupsPresenter
    
    init(output: AllGroupsModuleOutput) {
        view = AllGroupsViewController()
        let interactor = AllGroupsInteractor()
        
        presenter = AllGroupsPresenter()
        presenter.view = view
        presenter.interactor = interactor
        presenter.output = output
      
        view?.output = presenter
        interactor.output = presenter
    }
}

extension AllGroupsModule: ModulePresentable {
    func present(from viewController: UIViewController) {
        presenter.present(from: viewController)
    }
}
