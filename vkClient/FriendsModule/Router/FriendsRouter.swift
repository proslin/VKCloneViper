//
//  FriendsRouter.swift
//  vkClient
//
//  Created by Lina Prosvetova on 24.11.2022.
//

import Foundation
import UIKit

final class FriendsRouter {
    
}

extension FriendsRouter: FriendsRouterInput {
    func showFriendPhotos(friendId: Int, from vc: UIViewController?) {
        let friendPhotoModule = FriendPhotoModule(selectedFriendId: friendId)
        let friendPhotoVC = friendPhotoModule.vc
        vc?.show(friendPhotoVC, sender: nil)
    }
}
