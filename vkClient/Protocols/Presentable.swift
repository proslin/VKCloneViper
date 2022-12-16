//
//  Presentable.swift
//  vkClient
//
//  Created by Lina Prosvetova on 16.12.2022.
//

import UIKit

protocol Presentable: AnyObject {
    var viewController: UIViewController { get }
    
    func present(from viewController: UIViewController)
}

extension Presentable where Self: UIViewController {
    var viewController: UIViewController {
        return self
    }
    
    func present(from viewController: UIViewController) {
        viewController.navigationController?.pushViewController(self, animated: true)
    }
}
