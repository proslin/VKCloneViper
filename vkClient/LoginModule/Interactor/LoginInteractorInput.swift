//
//  LoginInteractorInput.swift
//  vkClient
//
//  Created by Lina Prosvetova on 22.11.2022.
//

import Foundation

protocol LoginInteractorInput: AnyObject {
    func getVKURLRequest() -> URLRequest?
}
