//
//  Session.swift
//  vkClient
//
//  Created by Lina Prosvetova on 31.10.2022.
//

import Foundation

final class Session {
    static let shared = Session()
    var token: String = ""
    var userId: Int = 0
    
    private init() {}
}
