//
//  FaceView.swift
//  FaceIt
//
//  Created by Steven Mitchell on 6/8/17.
//  Copyright © 2017 ThoughtWorks. All rights reserved.
//

import UIKit

class FaceView: UIView {

    private var skullRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2
    }
    
    private var skullCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.blue.set()
        pathForSkull().stroke()
    }

    private func pathForSkull() -> UIBezierPath {
        let path = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
        path.lineWidth = 5.0
        return path
    }
    
}
