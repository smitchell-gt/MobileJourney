//
//  ViewController.swift
//  FaceIt
//
//  Created by Steven Mitchell on 6/8/17.
//  Copyright © 2017 ThoughtWorks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var faceView: FaceView! {
        didSet {
            updateUI()
        }
    }
    
    var facialExpression = FacialExpression(eyes: .open, mouth: .grin) {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        switch facialExpression.eyes {
        case .open:
            faceView?.eyesOpen = true
        case .closed:
            faceView?.eyesOpen = false
        case .squinting:
            faceView?.eyesOpen = false
        }
        
        faceView.mouthCurvature = mouthCurvatures[facialExpression.mouth] ?? 0.0
    }
    
    private let mouthCurvatures = [FacialExpression.Mouth.frown: -1.0, .smirk: -0.5, .neutral: 0.0, .grin: 0.5, .smile: 1.0]
}

