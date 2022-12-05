//
//  VKFriendsVKFriendsInitializer.swift
//  vkCloneViper
//
//  Created by Prosvetova Lina on 18/11/2022.
//  Copyright © 2022 no company. All rights reserved.
//

import UIKit

class FriendsModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var friendsViewController: FriendsViewController!

    override func awakeFromNib() {

        let configurator = FriendsModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: friendsViewController)
    }

}
