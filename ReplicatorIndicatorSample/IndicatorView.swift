//
//  IndicatorView.swift
//  ReplicatorIndicatorSample
//
//  Created by Dung Vu on 10/26/16.
//  Copyright © 2016 Zinio Pro. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class IndicatorView: UIView {
    @IBInspectable var numberIndicator: Int = 10
    @IBInspectable var widthIndicator: CGFloat = 5
    @IBInspectable var heightIndicator: CGFloat = 25
    @IBInspectable var color: UIColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    @IBInspectable var speed: Double = 1
    
    private lazy var replicator = CAReplicatorLayer()
    private lazy var dot = CALayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        start()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupIndicator()
    }
    
    func setupIndicator() {
        let bView = self.bounds
        let sizeItem = min(bView.width, bView.height)
        replicator.anchorPoint =  CGPoint(x: 0.5, y: 0.5)
        replicator.frame = self.bounds.centerSquare
        self.layer.addSublayer(replicator)
        
        dot.frame = CGRect(
            x: sizeItem / 2 - widthIndicator / 2, y: 0,
            width: widthIndicator, height: heightIndicator)
        dot.backgroundColor = color.cgColor
        dot.borderColor = UIColor(white: 1.0, alpha: 1.0).cgColor
        dot.borderWidth = 0.5
        dot.cornerRadius = 1.5
        
        replicator.addSublayer(dot)
        
        replicator.instanceCount = numberIndicator
        let rotation = CGFloat.pi * 2.0 / CGFloat(numberIndicator)
        replicator.instanceTransform = CATransform3DRotate(CATransform3DIdentity, rotation, 0, 0, 1)
        replicator.instanceDelay = speed / CFTimeInterval(numberIndicator)
    }
    
    func start() {
        let fade = CABasicAnimation(keyPath: "opacity")
        fade.fromValue = NSNumber(floatLiteral: 1.0)
        fade.toValue = NSNumber(floatLiteral: 0.0)
        fade.duration = speed
        fade.repeatCount = Float.infinity
        dot.add(fade, forKey: "dotOpacity")
    }
    
    func stop() {
        self.layer.removeAllAnimations()
        self.replicator.removeFromSuperlayer()
        self.removeFromSuperview()
    }
}

extension CGRect {
    var centerSquare: CGRect {
        let side = min(width, height)
        
        return CGRect(
            x: midX - side / 2.0,
            y: midY - side / 2.0,
            width: side,
            height: side)
    }
}
