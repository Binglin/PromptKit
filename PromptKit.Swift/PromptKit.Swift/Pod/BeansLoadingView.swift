//
//  BeansLoadingView.swift
//  BeansLoading
//
//  Created by 郑林琴 on 16/1/27.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

import UIKit

class BeansLoadingView: UIView {
    
    var textLabel = UILabel()
    
    var dot1 = CAShapeLayer()
    var dot2 = CAShapeLayer()
    var dot3 = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let dotWidth:CGFloat = 3

        //0, 0, dotWidth, dotWidth
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: dotWidth, height: dotWidth)).cgPath
        dot1.path = path
        dot2.path = path
        dot3.path = path
        
        textLabel.text = "Loading"
        
        textLabel.sizeToFit()
        self.addSubview(textLabel)

        dot1.frame = CGRect(x: textLabel.frame.maxX + 3 , y: textLabel.frame.maxY - dotWidth, width: dotWidth, height: dotWidth)
        dot2.frame = CGRect(x: dot1.frame.maxX + 3 , y: textLabel.frame.maxY - dotWidth, width: dotWidth, height: dotWidth)
        dot3.frame = CGRect(x: dot2.frame.maxX + 3 , y: textLabel.frame.maxY - dotWidth, width: dotWidth, height: dotWidth)
        
        self.layer.addSublayer(dot1)
        self.layer.addSublayer(dot2)
        self.layer.addSublayer(dot3)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func startAnimating(){
        
        
//        let dotWidth: CGFloat = 3
        let maxY = 0 ;//textLabel.frame.maxY - dotWidth
        let minY = -textLabel.frame.height/2.0;//textLabel.frame.minY
        
        let keyframe1 = CAKeyframeAnimation(keyPath: "transform.translation.y")
        keyframe1.duration = 1
        keyframe1.keyTimes = [0, 0.2 , 0.4, 0.6 , 0.8, 1]
        keyframe1.values   = [maxY, minY,maxY,maxY,maxY, maxY]
        keyframe1.repeatCount = Float(UInt.max)
        
        dot1.add(keyframe1, forKey: "bean1")
        
        let keyframe2 = CAKeyframeAnimation(keyPath: "transform.translation.y")
        keyframe2.duration = 1
        keyframe2.keyTimes = keyframe1.keyTimes
        keyframe2.values   = [maxY, maxY, minY,maxY,maxY, maxY]
        keyframe2.repeatCount = Float(UInt.max)
        dot2.add(keyframe2, forKey: "bean2")
        
        let keyframe3 = CAKeyframeAnimation(keyPath: "transform.translation.y")
        keyframe3.duration = 1
        keyframe3.keyTimes = keyframe1.keyTimes
        keyframe3.values   = [maxY, maxY, maxY, minY,maxY, maxY]
        keyframe3.repeatCount = Float(UInt.max)
        dot3.add(keyframe3, forKey: "bean3")
        
    }
}
