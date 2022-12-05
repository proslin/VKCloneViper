//
//  LoginViewControllerIOutput.swift
//  vkClient
//
//  Created by Lina Prosvetova on 22.11.2022.
//

import Foundation
import UIKit

protocol LoginViewControllerIOutput: AnyObject {
    func viewIsReady()
    func authPageLoaded(vc: UIViewController)
}
