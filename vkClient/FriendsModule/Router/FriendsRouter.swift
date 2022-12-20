//
//  FriendsRouter.swift
//  vkClient
//
//  Created by Lina Prosvetova on 24.11.2022.
//

import UIKit

final class FriendsRouter: FriendsRouterInput {
    func showFriendPhotos(friendId: Int, from vc: UIViewController?) {
        guard let vc = vc else { return }
        FriendPhotoModule(selectedFriendId: friendId).present(from: vc)
    }
}
