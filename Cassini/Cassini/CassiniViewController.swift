//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Steven Mitchell on 7/12/17.
//  Copyright © 2017 ThoughtWorks. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController, UISplitViewControllerDelegate {
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.splitViewController?.delegate = self
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let url = HarpURL.thormahlen[segue.identifier ?? ""] {
            if let imageViewController = (segue.destination.contents as? ImageViewController) {
                imageViewController.imageUrl = url
                imageViewController.title = (sender as? UIButton)?.currentTitle
            }
        }
    }
    
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController) -> Bool {
        if primaryViewController.contents == self {
            if let imageViewController = secondaryViewController.contents as? ImageViewController, imageViewController.imageUrl == nil {
                return true
            }
        }
        return false
    }
}

extension UIViewController {
    var contents: UIViewController {
        if let navigationController = self as? UINavigationController {
            return navigationController.visibleViewController ?? self
        }
        
        return self
    }
}
