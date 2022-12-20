//
//  NavigationBarCustom.swift
//  vkClient
//
//  Created by Lina Prosvetova on 27.10.2022.
//

import UIKit

final class NavigationBarCustom: UIView {
    @IBOutlet private var leftButton: UIButton!
    @IBOutlet private var pageTitle: UILabel!
    @IBOutlet private var rightButton: UIButton!
    @IBOutlet private var searchBar: UISearchBar!
    
    @IBAction func leftButtonTapped(_ sender: Any) {
        leftButtonAction?()
    }
    @IBAction func rightButtonTapped(_ sender: Any) {
        rightButtonAction?()
    }

    private var leftButtonAction: (() -> ())?
    private var rightButtonAction: (() -> ())?
    
    // MARK: - Private methods
    private func setupParentViewConstraints(navigationView: NavigationBarCustom, parentView: UIView) {
        parentView.translatesAutoresizingMaskIntoConstraints = false
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        
        parentView.addSubview(navigationView)
        navigationView.topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
        parentView.bottomAnchor.constraint(equalTo: navigationView.bottomAnchor).isActive = true
        navigationView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive = true
        parentView.trailingAnchor.constraint(equalTo: navigationView.trailingAnchor).isActive = true
    }
    
    private func setupStyle() {
        pageTitle.textColor = VKColors.labelColor
        pageTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        searchBar.searchTextField.textColor = VKColors.labelColor
    }
    
    // MARK: - Public methods
    public class func instanceFromNib(model: NavigationBarProtocol, parentView: UIView) -> NavigationBarCustom? {
        let nib: NavigationBarCustom = NavigationBarCustom.viewForNibName()
        nib.setupParentViewConstraints(navigationView: nib, parentView: parentView)
        nib.pageTitle.text = model.title
        nib.leftButton.isHidden = true
        nib.searchBar.isHidden = true
        nib.rightButton.isHidden = true
        
        if model.rightButton != nil {
            nib.rightButton.isHidden = false
            nib.rightButton.setImage(UIImage(systemName: model.rightButton?.image ?? ""), for: .normal)
            nib.rightButtonAction = model.rightButton?.action
        }
        
        if model.leftButton != nil {
            nib.leftButton.isHidden = false
            nib.leftButton.setImage(UIImage(systemName: model.leftButton?.image ?? ""), for: .normal)
            nib.leftButtonAction = model.leftButton?.action
        }
        
        if model.isSearchBar {
            nib.searchBar.isHidden = false
            nib.pageTitle.isHidden = true
            nib.searchBar.placeholder = model.searchBarPlaceholder
            nib.searchBar.searchTextField.becomeFirstResponder()
        }
        
        nib.setupStyle()
        return nib
    }
    
    public func setupSearchBarDelegate(delegate: UISearchBarDelegate) {
        searchBar.delegate = delegate
    }
}
