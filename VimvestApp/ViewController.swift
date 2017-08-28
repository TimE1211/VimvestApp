//
//  ViewController.swift
//  VimvestApp
//
//  Created by Timothy Hang on 8/23/17.
//  Copyright © 2017 Timothy Hang. All rights reserved.
//

import UIKit
import GlidingCollection

class ViewController: UIViewController {

  var apiController = APIController()
  
  var posts = [Post]()
  
  @IBOutlet var glidingCollection: GlidingCollection!
  fileprivate var collectionView: UICollectionView!
  
  let transition = PopAnimator()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    apiController.delegate = self
    apiController.getPosts()
    setupGlidingCollectionView()
  }
}

extension ViewController: APIControllerDelegate {
  func didReceivePosts(_ posts: [Post]) {
    self.posts = posts
    self.collectionView.reloadData()
  }
}

extension ViewController {
  func setupGlidingCollectionView() {
    glidingCollection.dataSource = self
    
    let nib = UINib(nibName: "PostCell", bundle: nil)
    collectionView = glidingCollection.collectionView
    collectionView.register(nib, forCellWithReuseIdentifier: "PostCell")
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.backgroundColor = glidingCollection.backgroundColor
  }
}

extension ViewController: GlidingCollectionDatasource {
  func numberOfItems(in collection: GlidingCollection) -> Int {
    return 1
  }
  
  func glidingCollection(_ collection: GlidingCollection, itemAtIndex index: Int) -> String {
    return "- Posts"
  }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return posts.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as? PostCell else { return UICollectionViewCell() }
    
    cell.contentView.clipsToBounds = true
    
    let layer = cell.layer
    let config = GlidingConfig.shared
    layer.shadowOffset = config.cardShadowOffset
    layer.shadowColor = config.cardShadowColor.cgColor
    layer.shadowOpacity = config.cardShadowOpacity
    layer.shadowRadius = config.cardShadowRadius
    
    layer.shouldRasterize = true
    layer.rasterizationScale = UIScreen.main.scale
    
    let post = posts[indexPath.row]
    
    cell.postImageView.image = UIImage(named: "Blank52")
    cell.idLabel.text = String(post.id) + ": " + post.title
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let aPost = posts[indexPath.row]
    
    if let postDetailVC = storyboard?.instantiateViewController(withIdentifier: "PostDetailViewController") as? PostDetailViewController {
      postDetailVC.post = aPost
      let selectedImage = UIImage(named: "Blank52")
      postDetailVC.postImage = selectedImage
      
      show(postDetailVC, sender: self)
    }
  }
  
}

extension ViewController: UIViewControllerTransitioningDelegate {
  func animationController(forPresented presented: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    transition.presenting = true
    return transition
  }
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    transition.presenting = false
    return transition
  }
}
