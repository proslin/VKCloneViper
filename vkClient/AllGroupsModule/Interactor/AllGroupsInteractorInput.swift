//
//  AllGroupsInteractorInput.swift
//  vkClient
//
//  Created by Lina Prosvetova on 28.11.2022.
//

import Foundation

protocol AllGroupsInteractorInput {
    var output: AllGroupsInteractorOutput? { get set }
    
    func getSearchesGroup(for searchRequest: String)
}
