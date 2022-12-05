//
//  FriendPhotoViewControllerOutput.swift
//  vkClient
//
//  Created by Lina Prosvetova on 21.11.2022.
//

import Foundation

protocol FriendPhotoViewControllerOutput {
    func viewIsReady()
    func getPhotosCount() -> Int
    func getPhotoFor(row: Int) -> PhotoModel
    func refreshDragged()
    func getSelectedModel(selectedFriendID: Int)
    func getMorePhoto(row: Int)
}
