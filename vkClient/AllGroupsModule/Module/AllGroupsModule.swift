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
    
    public let vc: AllGroupsViewController
    
    init(output: AllGroupsModuleOutput) {
        vc = AllGroupsViewController()
        view = vc
        let interactor = AllGroupsInteractor()
        
        presenter = AllGroupsPresenter()
        presenter.view = view
        presenter.interactor = interactor
        presenter.output = output
      
        view?.output = presenter
        interactor.output = presenter
    }
}

