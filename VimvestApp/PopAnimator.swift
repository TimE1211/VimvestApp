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
  let duration = 1.0
  var presenting = true
  var originFrame = CGRect.zero
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let containerView = transitionContext.containerView
    let toView = transitionContext.view(forKey: .to)!
    
    containerView.addSubview(toView)
    toView.alpha = 0.0
    UIView.animate(withDuration: duration, animations: {
      toView.alpha = 1.0
    }, completion: { _ in
      transitionContext.completeTransition(true)
    })
  }
}
