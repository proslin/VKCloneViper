//
//  FriendsVKFriendsViewController.swift
//  vkCloneViper
//
//  Created by Prosvetova Lina on 18/11/2022.
//  Copyright © 2022 no company. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController, FriendsViewInput {

    var output: FriendsViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }


    // MARK: FriendsViewInput
    func setupInitialState() {
    }
}
