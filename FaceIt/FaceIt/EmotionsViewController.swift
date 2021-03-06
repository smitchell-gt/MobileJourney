//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by Steven Mitchell on 7/6/17.
//  Copyright © 2017 ThoughtWorks. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationViewController = segue.destination
        
        if let navigationViewController = destinationViewController as? UINavigationController {
            destinationViewController = navigationViewController.visibleViewController ?? destinationViewController
        }
        
        if let faceViewController = destinationViewController as? FaceViewController,
            let segueId = segue.identifier,
            let expression = emotionalFaces[segueId] {
                faceViewController.facialExpression = expression
                faceViewController.navigationItem.title = (sender as? UIButton)?.currentTitle
        }
    }
    
    private let emotionalFaces: Dictionary<String,FacialExpression> = [
        "happy" : FacialExpression(eyes: .open, mouth: .smile),
        "sad" : FacialExpression(eyes: .closed, mouth: .frown),
        "worried" : FacialExpression(eyes: .open, mouth: .smirk)
    ]
}
