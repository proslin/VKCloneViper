//
//  LoginViewControllerInput.swift
//  vkClient
//
//  Created by Lina Prosvetova on 22.11.2022.
//

import Foundation

protocol LoginViewControllerInput: AnyObject {
    var output: LoginViewControllerIOutput? { get set }
    
    func loadURLRequest(_ request: URLRequest?)
}
