//
//  ViewController.swift
//  VimvestApp
//
//  Created by Timothy Hang on 8/23/17.
//  Copyright © 2017 Timothy Hang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var apiController = APIController()
  
  var tableView: UITableView!
  
  var posts = [Post]()
  
  @IBOutlet var glidingCollection: GlidingCollection!
  fileprivate var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    apiController.delegate = self
    apiController.getPosts()
  }
}

extension ViewController: APIControllerDelegate {
  
  func didReceivePosts(_ posts: [Post]) {
    self.posts = posts
    self.tableView.reloadData()
  }
}

extension PostersViewController: GlidingCollectionDatasource
{
  func numberOfItems(in collection: GlidingCollection) -> Int
  {
    return 1
  }
  
  func glidingCollection(_ collection: GlidingCollection, itemAtIndex index: Int) -> String {
    return "- Posts"
  }
}
