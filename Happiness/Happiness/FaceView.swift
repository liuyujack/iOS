//
//  FaceView.swift
//  Happiness
//
//  Created by Yu Liu on 25/09/2015.
//  Copyright © 2015 Yu Liu. All rights reserved.
//

import UIKit
@IBDesignable

class FaceView: UIView {
    
    @IBInspectable
    var lineWidth: CGFloat = 3 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable
    var colour: UIColor = UIColor.blackColor() {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable
    var scale: CGFloat = 0.9{
        didSet {
            setNeedsDisplay()
        }
    }
    
    private struct Scaling {
        static let FaceRadiusToEyeRadiusRatio: CGFloat = 10
        static let FaceRadiusToEyeOffsetRatio: CGFloat = 3
        static let FaceRadiusToEyeSeparationRatio: CGFloat = 2
        static let FaceRadiusToMouthWidthRatio: CGFloat = 1
        static let FaceRadiusToMouthHeightRatio: CGFloat = 3
        static let FaceRadiusToMouthOffsetRatio: CGFloat = 3
    }
    
    private enum Eye {case Left, Right}
    
    private func bezierPathForEye(whichEye: Eye) -> UIBezierPath
    {
        let eyeRadius = faceRadius/Scaling.FaceRadiusToEyeRadiusRatio
        let eyeVerticalOffset = faceRadius/Scaling.FaceRadiusToEyeOffsetRatio
        let eyeHorizontalSeparation = faceRadius/Scaling.FaceRadiusToEyeSeparationRatio
        
        var eyeCentre = faceCentre
        eyeCentre.y -= eyeVerticalOffset
        switch whichEye {
        case .Left: eyeCentre.x -= eyeHorizontalSeparation
        case .Right: eyeCentre.x += eyeHorizontalSeparation
        }
        
        let path = UIBezierPath(arcCenter: eyeCentre, radius: eyeRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        
        path.lineWidth = lineWidth
        
        return path
    }
    
    private func bezierPathForSmile(fractionOfMaxSmile: Double) ->UIBezierPath
    {
        let mouthWidth = faceRadius / Scaling.FaceRadiusToMouthWidthRatio
        let mouthHeight = faceRadius / Scaling.FaceRadiusToMouthHeightRatio
        let mouthVerticalOffset = faceRadius / Scaling.FaceRadiusToMouthOffsetRatio
        
        let smileHeight = CGFloat(max(min(fractionOfMaxSmile,1),-1)) * mouthHeight
        
        let start = CGPoint(x: faceCentre.x - mouthWidth / 2, y: faceCentre.y + mouthVerticalOffset)
        let end = CGPoint(x: start.x + mouthWidth,y: start.y)
        let cp1 = CGPoint(x: start.x + mouthWidth / 3 , y: start.y + smileHeight)
        let cp2 = CGPoint(x: end.x - mouthWidth / 3 , y: start.y + smileHeight)
        
        let path = UIBezierPath()
        path.moveToPoint(start)
        path.addCurveToPoint(end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        return path
    }
    
    var faceCentre: CGPoint
    {
        return convertPoint(center, fromView: superview)
    }
    
    var faceRadius: CGFloat
    {
        return min(bounds.size.width, bounds.size.height)/2 * scale
    }

    override func drawRect(rect: CGRect)
    {
        let facePath = UIBezierPath(arcCenter: faceCentre, radius: faceRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        facePath.lineWidth = lineWidth
        colour.set()
        facePath.stroke()
        
        bezierPathForEye(.Left).stroke()
        bezierPathForEye(.Right).stroke()
        
        let smiliness = 0.8
        
        bezierPathForSmile(smiliness).stroke()
    }

}
