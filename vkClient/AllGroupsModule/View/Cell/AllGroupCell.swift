//
//  AllGroupCell.swift
//  vkClient
//
//  Created by Lina Prosvetova on 26.10.2022.
//

import UIKit

class AllGroupCell: UITableViewCell {
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupAvatar: AvatarView!
    @IBOutlet weak var memberCount: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        groupAvatar.setEmptyAvatarImage()
    }
    
    func set(group: GroupModel) {
        groupName.textColor = VKColors.labelColor
        groupName.text = group.groupName
        memberCount.textColor = VKColors.secondLabelColor
        memberCount.text = "\(group.membersCount ?? 0) участников"
        NetworkService.shared.downloadAvatar(from: group.groupAvatarURL, to: groupAvatar.getAvatarImageView())
    }
}
