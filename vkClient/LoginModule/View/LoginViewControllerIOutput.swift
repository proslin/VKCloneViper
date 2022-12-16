//
//  LoginViewControllerIOutput.swift
//  vkClient
//
//  Created by Lina Prosvetova on 22.11.2022.
//

import UIKit

protocol LoginViewControllerIOutput: AnyObject {
    func viewIsReady()
    func authPageLoaded(vc: UIViewController)
    func getTokenFrom(urlFragment: String)
}
