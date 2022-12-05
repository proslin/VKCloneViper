//
//  FriendPhotoCell.swift
//  vkClient
//
//  Created by Lina Prosvetova on 11.10.2022.
//

import UIKit

class FriendPhotoCell: UICollectionViewCell {

    @IBOutlet weak var photo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func set(photo: PhotoModel) {
        NetworkService.shared.downloadAvatar(from: photo.photoURL, to: self.photo)
    }
}
