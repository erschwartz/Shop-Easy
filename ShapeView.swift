//
//  ShapeView.swift
//  ShapesTutorial
//
//  Created by Silviu Pop on 7/27/15.
//  Copyright (c) 2015 WeHeartSwift. All rights reserved.
//
//Modified for Shop Easy

import UIKit

class ShapeView: UIView {
    
    let size: CGFloat = 100
    let lineWidth: CGFloat = 2
    var fillColor: UIColor!
    var path: UIBezierPath!
    
    func randomColor() -> UIColor {
        let hue:CGFloat = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        return UIColor(hue: hue, saturation: 0.2, brightness: 1.0, alpha: 0.7)
    }
    
    func randomPath() -> UIBezierPath {
        
        let insetRect = CGRectInset(self.bounds,lineWidth,lineWidth)
        return UIBezierPath(rect: insetRect)
    }
    
    init(origin: CGPoint) {
        
        super.init(frame: CGRectMake(0.0, 0.0, size, size))
        self.fillColor = randomColor()
        self.path = randomPath()
        self.path = randomPath()
        self.center = origin
        self.backgroundColor = UIColor.clearColor()
        initGestureRecognizers()
    }
    
    func initGestureRecognizers() {
        let panGR = UIPanGestureRecognizer(target: self, action: "didPan:")
        addGestureRecognizer(panGR)
        
        let pinchGR = UIPinchGestureRecognizer(target: self, action: "didPinch:")
        addGestureRecognizer(pinchGR)
    }
    
    func didPan(panGR: UIPanGestureRecognizer) {
        
        self.superview!.bringSubviewToFront(self)
        
        var translation = panGR.translationInView(self)
        
        translation = CGPointApplyAffineTransform(translation, self.transform)
        
        self.center.x += translation.x
        self.center.y += translation.y
        
        panGR.setTranslation(CGPointZero, inView: self)
    }
    
    func didPinch(pinchGR: UIPinchGestureRecognizer) {

        self.superview!.bringSubviewToFront(self)
        let scale = pinchGR.scale
        var newFrame = self.frame
        switch (detectDirection(pinchGR)) {
        case 1:
            self.transform = CGAffineTransformScale(self.transform, scale, 1)
            newFrame.size = CGSizeMake(scale * newFrame.size.width, newFrame.size.height)
        case 2:
            self.transform = CGAffineTransformScale(self.transform, 1, scale)
            newFrame.size = CGSizeMake(newFrame.size.width, newFrame.size.height * scale)
        default:
            self.transform = CGAffineTransformScale(self.transform, scale, scale)
            newFrame.size = CGSizeMake(scale * newFrame.size.width, newFrame.size.height * scale)
        }
        pinchGR.scale = 1.0
        self.frame = newFrame
//        self.center.x += self.transform.a
//        self.center.y += translation.y
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        
        self.fillColor.setFill()
        self.path.fill()
        self.path.lineWidth = self.lineWidth
        UIColor.blackColor().setStroke()
        self.path.stroke()
    }
    
    func detectDirection(pinchRecognizer: UIPinchGestureRecognizer) -> Int {
        if (pinchRecognizer.state == UIGestureRecognizerState.Began || pinchRecognizer.state == UIGestureRecognizerState.Changed) {
            if (pinchRecognizer.numberOfTouches() > 1) {
                let view = pinchRecognizer.view
                let locationOne = pinchRecognizer.locationOfTouch(0, inView: view)
                let locationTwo = pinchRecognizer.locationOfTouch(1, inView: view)
                var theSlope: Double;
                
                if (locationOne.x == locationTwo.x) {
                    theSlope = 1000.0;
                } else if (locationOne.y == locationTwo.y) {
                    theSlope = 0;
                } else {
                    theSlope = Double((locationTwo.y - locationOne.y) / (locationTwo.x - locationOne.x));
                }
                
                let absoluteSlope = abs(theSlope);
                if (absoluteSlope < 0.5) {
                    return 1;
                } else if (absoluteSlope > 1.7) {
                    return 2;
                } else {
                    return 3;
                }
            }
        }
        return -1;
    }
    
}