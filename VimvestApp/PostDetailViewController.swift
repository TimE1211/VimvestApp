//
//  PostDetailViewController.swift
//  
//
//  Created by Timothy Hang on 8/27/17.
//
//

import UIKit

class PostDetailViewController: UIViewController {
  
  var post: Post?
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var postImageView: UIImageView!
  @IBOutlet weak var overviewTextView: UITextView!
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    titleLabel.text = post?.title
    overviewTextView.text = post?.body
  }
}

