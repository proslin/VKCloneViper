//
//  UserGroupCell.swift
//  vkClient
//
//  Created by Lina Prosvetova on 18.10.2022.
//

import UIKit

class UserGroupCell: UITableViewCell {
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupAvatar: AvatarView!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        groupAvatar.setEmptyAvatarImage()
    }
    
    func set(group: GroupModel) {
        groupName.text = group.groupName
        groupName.textColor = VKColors.labelColor
        NetworkService.shared.downloadAvatar(from: group.groupAvatarURL, to: groupAvatar.getAvatarImageView())
    }
    
}
