//
//  PopAnimator.swift
//  VimvestApp
//
//  Created by Timothy Hang on 8/28/17.
//  Copyright © 2017 Timothy Hang. All rights reserved.
//

import UIKit
//https://www.raywenderlich.com/146692/ios-animation-tutorial-custom-view-controller-presentation-transitions-2

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  let duration = 2.0
  var presenting = true
  var originFrame = CGRect.zero
  var dismissCompletion: (()->Void)?
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let containerView = transitionContext.containerView
    let toView = transitionContext.view(forKey: .to)!
    let herbView = presenting ? toView :
      transitionContext.view(forKey: .from)!
    let initialFrame = presenting ? originFrame : herbView.frame
    let finalFrame = presenting ? herbView.frame : originFrame
    
    let xScaleFactor = presenting ?
      
      initialFrame.width / finalFrame.width :
      finalFrame.width / initialFrame.width
    
    let yScaleFactor = presenting ?
      
      initialFrame.height / finalFrame.height :
      finalFrame.height / initialFrame.height
    
    let scaleTransform = CGAffineTransform(scaleX: xScaleFactor,
                                           y: yScaleFactor)
    
    if presenting {
      herbView.transform = scaleTransform
      herbView.center = CGPoint(
        x: initialFrame.midX,
        y: initialFrame.midY)
      herbView.clipsToBounds = true
    }
    
    containerView.addSubview(toView)
    containerView.bringSubview(toFront: herbView)
    
    UIView.animate(withDuration: duration, delay:0.0,
                   usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0,
                   animations: {
                    herbView.transform = self.presenting ?
                      CGAffineTransform.identity : scaleTransform
                    herbView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
    }, 
                   completion:{_ in
                    if !self.presenting {
                      self.dismissCompletion?()
                    }
                    transitionContext.completeTransition(true)
    }
    )
  }
}
