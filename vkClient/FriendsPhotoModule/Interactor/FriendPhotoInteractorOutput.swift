//
//  FriendPhotoInteractorOutput.swift
//  vkClient
//
//  Created by Lina Prosvetova on 21.11.2022.
//

import Foundation

protocol FriendPhotoInteractorOutput: AnyObject {
    func initializedData()
    func updatedData(deletions: [Int], insertions: [Int], modifications: [Int])
    func getDataFail(_ error: Error)
    func getPhotossSuccess (_ photos: [PhotoModel])
    func getPhotosFail(_ error: ErrorMessage)
    func getAllPhotosCount(allPhotosCount: Int)
    func dataBaseFail(_ error: Error)
}

