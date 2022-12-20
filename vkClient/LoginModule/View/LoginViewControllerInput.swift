//
//  LoginViewControllerInput.swift
//  vkClient
//
//  Created by Lina Prosvetova on 22.11.2022.
//

import UIKit

protocol LoginViewControllerInput: Presentable {
    var output: LoginViewControllerIOutput? { get set }
    
    func loadURLRequest(_ request: URLRequest?)
    func getVC() -> UIViewController?
}
