//
//  FriendsVKFriendsPresenter.swift
//  vkCloneViper
//
//  Created by Prosvetova Lina on 18/11/2022.
//  Copyright © 2022 no company. All rights reserved.
//

class FriendsPresenter: FriendsModuleInput, FriendsViewOutput, FriendsInteractorOutput {

    weak var view: FriendsViewInput!
    var interactor: FriendsInteractorInput!
    var router: FriendsRouterInput!

    func viewIsReady() {

    }
}
