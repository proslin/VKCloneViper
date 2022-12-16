//
//  FriendPhotoInteractor.swift
//  vkClient
//
//  Created by Lina Prosvetova on 21.11.2022.
//

import Foundation
import RealmSwift

final class FriendPhotoInteractor{
    weak var output: FriendPhotoInteractorOutput?
    private var token: NotificationToken?
    private var friends: Results<FriendModel>?
    private var photos: Results<PhotoModel>?
    private var photosCount: Int = 0

    // MARK: Private methods
    private func getPhotosFromNetwork(selectedFriendID: Int, offset: Int, isLoadingMorePhotos: Bool = false) {
        NetworkService.shared.getPhotos(for: selectedFriendID, offset: offset) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let photosResponse):
                self.photosCount = photosResponse.response.count
                self.output?.getAllPhotosCount(allPhotosCount: self.photosCount)
                let currentPhotoResponse = photosResponse.response.items
                let currentResponseWithURL = currentPhotoResponse
                for photo in currentResponseWithURL {
                    photo.photoURL = photo.sizes.first(where: { $0.type == "m" })?.url ?? ""
                }
                DispatchQueue.main.async {
                    if let error = RealmService.shared.savePhoto(currentResponseWithURL, ownerId: selectedFriendID, isLoadimgMorePhoto: isLoadingMorePhotos) {
                        self.output?.dataBaseFail(error)
                    } else {
                    self.output?.getPhotossSuccess(currentResponseWithURL)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.output?.getPhotosFail(error)
                }
            }
        }
    }
    
    private func getPhotosFromRealm() {
        self.photos = RealmService.shared.loadPhoto()
        guard let photos = photos,
              !photos.isEmpty else {
                  output?.getPhotosFail(.invalidData)
                  return
              }
        output?.getPhotossSuccess(Array(photos))
    }
}

extension FriendPhotoInteractor: FriendPhotoInteractorInput {
    func startObserving() {
        token = photos?.observe { [weak self] changes in
            switch changes {
            case .initial:
                self?.output?.initializedData()
            case .update(_, let deletions, let insertions, let modifications):
                self?.output?.updatedData(deletions: deletions, insertions: insertions, modifications: modifications)
            case .error(let error):
                self?.output?.getDataFail(error)
            }
        }
    }
    
    func getPhotos(for friendID: Int, offset: Int, isLoadingMorePhotos: Bool = false) {
        getPhotosFromNetwork(selectedFriendID: friendID, offset: offset, isLoadingMorePhotos: isLoadingMorePhotos)
    }
    
    
}
