//
//  Post.swift
//  VimvestApp
//
//  Created by Timothy Hang on 8/26/17.
//  Copyright © 2017 Timothy Hang. All rights reserved.
//

import Foundation
import SwiftyJSON

class Post
{
  let id: Int
  let title: String
  let body: String
  
  init(postJson: JSON)
  {
    id = postJson["id"].intValue
    title = postJson["title"].stringValue
    body = postJson["body"].stringValue
  }
}
