//
//  NavigationBarModel.swift
//  vkClient
//
//  Created by Lina Prosvetova on 16.12.2022.
//

import Foundation

protocol NavBarButtonProtocol {
    var image: String { get set }
    var action: (() -> ())? { get set }
}

protocol NavigationBarProtocol {
    var title: String { get set }
    var leftButton: NavBarButtonProtocol? { get set }
    var rightButton: NavBarButtonProtocol? { get set }
    var isSearchBar: Bool { get set }
    var searchBarPlaceholder: String { get set }
}

struct NavigationBarModel: NavigationBarProtocol {
    var title: String
    var leftButton: NavBarButtonProtocol?
    var rightButton: NavBarButtonProtocol?
    var isSearchBar: Bool = false
    var searchBarPlaceholder: String = ""
}

struct NavBarButton: NavBarButtonProtocol {
    var image: String
    var action: (() -> ())?
}
