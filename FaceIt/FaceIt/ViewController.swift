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
            let handler = #selector(FaceView.changeScale(byReactingTo:))
            let pinchRecognizer = UIPinchGestureRecognizer(target: faceView, action: handler)
            faceView.addGestureRecognizer(pinchRecognizer)
            
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleEyes(byReactingTo:)))
            faceView.addGestureRecognizer(tapRecognizer)
            
            let swipeUpRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(increaseHappiness))
            swipeUpRecognizer.direction = .up
            faceView.addGestureRecognizer(swipeUpRecognizer)
            
            let swipeDownRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(decreaseHappiness))
            swipeDownRecognizer.direction = .down
            faceView.addGestureRecognizer(swipeDownRecognizer)
            
            updateUI()
        }
    }
    
    var facialExpression = FacialExpression(eyes: .open, mouth: .grin) {
        didSet {
            updateUI()
        }
    }
    
    func toggleEyes(byReactingTo tapRecognizer: UITapGestureRecognizer) {
        if tapRecognizer.state == .ended {
            let eyes: FacialExpression.Eyes = (facialExpression.eyes == .closed) ? .open : .closed
            facialExpression = FacialExpression(eyes: eyes, mouth: facialExpression.mouth)
        }
    }
    
    func increaseHappiness() {
        facialExpression = facialExpression.happier
    }
    
    func decreaseHappiness() {
        facialExpression = facialExpression.sadder
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

