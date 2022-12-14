//
//  UIHelper.swift
//  vkClient
//
//  Created by Lina Prosvetova on 26.10.2022.
//

import UIKit

enum UIHelper {
    static func createThreeColumnFlowLayout(width: CGFloat, padding: CGFloat) -> UICollectionViewFlowLayout {
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        return flowLayout
    }
}
