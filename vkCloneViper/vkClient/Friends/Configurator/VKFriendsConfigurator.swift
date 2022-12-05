//
//  VKFriendsVKFriendsConfigurator.swift
//  vkCloneViper
//
//  Created by Prosvetova Lina on 18/11/2022.
//  Copyright © 2022 no company. All rights reserved.
//

import UIKit

class FriendsModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? FriendsViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: FriendsViewController) {

        let router = FriendsRouter()

        let presenter = FriendsPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = FriendsInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
