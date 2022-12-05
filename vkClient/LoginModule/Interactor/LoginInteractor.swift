//
//  LoginInteractor.swift
//  vkClient
//
//  Created by Lina Prosvetova on 22.11.2022.
//

import Foundation

final class LoginInteractor {
    
}

extension LoginInteractor: LoginInteractorInput {
    func getVKURLRequest() -> URLRequest? {
        NetworkService.shared.getVkURLRequest()
    }
}
