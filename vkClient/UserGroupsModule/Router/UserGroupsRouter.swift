//
//  UserGroupsRouter.swift
//  vkClient
//
//  Created by Lina Prosvetova on 28.11.2022.
//

import Foundation
import UIKit

final class UserGroupsRouter {

}

extension UserGroupsRouter: UserGroupsRouterInput {
    func showGroupSearch(from vc: UIViewController?, output: AllGroupsModuleOutput) {
        let allGroupsModule = AllGroupsModule(output: output)
        let allGroupsVC = allGroupsModule.vc
        vc?.show(allGroupsVC, sender: nil)
    }
    
}
