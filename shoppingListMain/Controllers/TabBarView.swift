//
//  ViewController.swift
//  shoppingListMain
//
//  Created by Виталий on 8/1/20.
//  Copyright © 2020 Виталий. All rights reserved.
//

import UIKit

@IBDesignable
class TabBarView: UIView {
    
    private var shapeLayer: CALayer?
    
    override func draw(_ rect: CGRect) {
        self.addShape()
    }
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        shapeLayer.lineWidth = 0.5
        shapeLayer.shadowOffset = CGSize(width:0, height:0)
        shapeLayer.shadowColor = UIColor.gray.cgColor
        shapeLayer.shadowRadius = 5
        shapeLayer.shadowOpacity = 0.1
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
        
        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }
    
    
    func createPath() -> CGPath {

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: -25))
        
        path.addCurve(to: CGPoint(x: 25, y: 0),
                      controlPoint1: CGPoint(x: 0, y: 0), controlPoint2: CGPoint(x: 25, y: 0))
        
        path.addLine(to: CGPoint(x: self.frame.width - 25, y: 0))
        
        path.addCurve(to: CGPoint(x: self.frame.width, y: -25),
                      controlPoint1: CGPoint(x: self.frame.width - 25, y: 0), controlPoint2: CGPoint(x: self.frame.width, y: 0))
        
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        return path.cgPath
    }
    
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }
        for member in subviews.reversed() {
            let subPoint = member.convert(point, from: self)
            guard let result = member.hitTest(subPoint, with: event) else { continue }
            return result
        }
        return nil
    }
}

