//
//  APIController.swift
//  VimvestApp
//
//  Created by Timothy Hang on 8/23/17.
//  Copyright © 2017 Timothy Hang. All rights reserved.
//


import Foundation
import Alamofire
import SwiftyJSON

protocol APIControllerDelegate
{
  func didReceivePosts(_ posts: [Post])
}

class APIController
{
  let baseURL = "https://jsonplaceholder.typicode.com/"
  var postsURL: String {
    return baseURL + "/posts"
  }
  
  var posts = [Post]()
  
  var delegate: APIControllerDelegate?
  
  func getPosts()
  {
    let sessionURL = postsURL
    Alamofire.request(sessionURL).responseJSON { responseData in
      if let value = responseData.result.value
      {
        let postsJson = JSON(value).arrayValue
        
        for aPostJson in postsJson {
          let aPost = Post(postJson: aPostJson)
          self.posts.append(aPost)
        }
        self.delegate?.didReceivePosts(self.posts)
      }
    }
  }
}
