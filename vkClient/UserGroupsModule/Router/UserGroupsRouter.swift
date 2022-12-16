//
//  UserGroupsRouter.swift
//  vkClient
//
//  Created by Lina Prosvetova on 28.11.2022.
//

import UIKit

final class UserGroupsRouter {

}

extension UserGroupsRouter: UserGroupsRouterInput {
    func showGroupSearch(from vc: UIViewController?, output: AllGroupsModuleOutput) {
        guard let vc = vc else { return }
        AllGroupsModule(output: output).present(from: vc)

    }    
}
