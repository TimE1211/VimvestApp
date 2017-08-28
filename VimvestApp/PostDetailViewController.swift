//
//  PostDetailViewController.swift
//  
//
//  Created by Timothy Hang on 8/27/17.
//
//

import UIKit

class PostDetailViewController: UIViewController, UIViewControllerTransitioningDelegate {
  
  var post: Post?
  var postImage: UIImage?
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var postImageView: UIImageView!
  @IBOutlet weak var overviewTextView: UITextView!
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    titleLabel.text = post?.title
    overviewTextView.text = post?.body
    overviewTextView.isEditable = false
    postImageView.image = postImage
    
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionClose(_:))))
  }
  
  func actionClose(_ tap: UITapGestureRecognizer) {
    presentingViewController?.dismiss(animated: true, completion: nil)
  }
}

