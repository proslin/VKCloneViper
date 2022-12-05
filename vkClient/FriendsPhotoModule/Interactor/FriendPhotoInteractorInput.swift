//
//  FriendPhotoInteractorInput.swift
//  vkClient
//
//  Created by Lina Prosvetova on 21.11.2022.
//

import Foundation

protocol FriendPhotoInteractorInput {
    var output: FriendPhotoInteractorOutput? { get set }
    
    func getPhotos(for friendID: Int, offset: Int, isLoadingMorePhotos: Bool)
    func startObserving()
}
