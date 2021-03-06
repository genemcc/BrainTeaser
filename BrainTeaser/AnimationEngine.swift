//
//  AnimationEngine.swift
//  BrainTeaser
//
//  Created by Gene McCullagh on 3/27/16.
//  Copyright © 2016 Gene McCullagh. All rights reserved.
//

import UIKit
import pop

class AnimationEngine {
    
    class var offScreenRightPosition: CGPoint {
        return CGPointMake(UIScreen.mainScreen().bounds.width, CGRectGetMidY(UIScreen.mainScreen().bounds))
    }
    
    class var offScreenLeftPosition: CGPoint {
        return CGPointMake(-UIScreen.mainScreen().bounds.width, CGRectGetMidY(UIScreen.mainScreen().bounds))
    }
    
    class var screenCenterPosition: CGPoint {
        return CGPointMake(CGRectGetMidX(UIScreen.mainScreen().bounds), CGRectGetMidY(UIScreen.mainScreen().bounds))
    }
    
    var originalConstants = [CGFloat]()
    var constraints: [NSLayoutConstraint]!
    
    init(constraints: [NSLayoutConstraint]) {
        for con in constraints {
            originalConstants.append(con.constant)
            con.constant = AnimationEngine.offScreenRightPosition.x
        }
        
        self.constraints = constraints
    }
    
    func animateOnScreen(delay: Int)  {
        
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64((Double(delay) * Double(NSEC_PER_SEC))))
        
        dispatch_after(time, dispatch_get_main_queue()) {
            
            var index = 0
            repeat {
                let moveAnim = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
                moveAnim.toValue = self.originalConstants[index]
                moveAnim.springSpeed = 6
                moveAnim.springBounciness = 12
                
                if index > 0 {
                    moveAnim.dynamicsFriction += 10 + CGFloat(index)
                    //moveAnim.dynamicsMass = 3
                }
                
                let con = self.constraints[index]
                con.pop_addAnimation(moveAnim, forKey: "moveOnScreen")
                
                index += 1
                
            } while (index < self.constraints.count)
            
        }
        
        
    }
    
    class func animateToPosition(view: UIView, position: CGPoint, completion: ((POPAnimation!, Bool) -> Void)) -> Void {
        let moveAnim = POPSpringAnimation(propertyNamed: kPOPLayerPosition)
        moveAnim.toValue = NSValue(CGPoint: position)
        moveAnim.springBounciness = 10
        moveAnim.springSpeed = 10
        moveAnim.completionBlock = completion
        view.pop_addAnimation(moveAnim, forKey: "moveToPosition")
    }
    
    
}
