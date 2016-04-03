//
//  CustomButton.swift
//  BrainTeaser
//
//  Created by Gene McCullagh on 3/27/16.
//  Copyright © 2016 Gene McCullagh. All rights reserved.
//

import UIKit
import pop

@IBDesignable
class CustomButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var fontColor: UIColor = UIColor.whiteColor() {
        didSet {
            self.tintColor = fontColor
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    override func awakeFromNib() {
        setupView()
        
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.addTarget(self, action: #selector(CustomButton.scaleToSmall), forControlEvents: .TouchDown)
        self.addTarget(self, action: #selector(CustomButton.scaleToSmall), forControlEvents: .TouchDragEnter)
        self.addTarget(self, action: #selector(CustomButton.scaleAnimation), forControlEvents: .TouchUpInside)
        self.addTarget(self, action: #selector(CustomButton.scaleDefault), forControlEvents: .TouchDragExit)
        
        
        
    }
    
    func scaleToSmall() {
        let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim.toValue = NSValue(CGSize: CGSizeMake(0.90, 0.90))
        self.layer.pop_addAnimation(scaleAnim, forKey: "layerScaleSmallAnimation")
    }
    
    func scaleAnimation() {
        let scaleAnim = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim.velocity = NSValue(CGSize: CGSizeMake(3.0, 3.0))
        scaleAnim.toValue = NSValue(CGSize: CGSizeMake(1.0, 1.0))
        scaleAnim.springBounciness = 20
        self.layer.pop_addAnimation(scaleAnim, forKey: "layerScaleSpringAnimation")
    }
    
    func scaleDefault() {
        let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim.toValue = NSValue(CGSize: CGSizeMake(1.0, 1.0))
        self.layer.pop_addAnimation(scaleAnim, forKey: "LayerScaleDefaultAnimation")
        
    }
    
}
