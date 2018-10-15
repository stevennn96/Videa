//
//  MyVideo.swift
//  Videa
//
//  Created by Kensen Tjoa on 13/10/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import Foundation

class MyVideo {
    
    var imageUrl: String?
    var title: String?
    var viewCount: String?
    var commentCount: String?
    var likeCount: String?
    var dislikeCount: String?
    
    init(imageUrl: String, title: String, viewCount: String, commentCount: String, likeCount: String, dislikeCount: String) {
        self.imageUrl = imageUrl
        self.title = title
        self.viewCount = viewCount
        self.commentCount = commentCount
        self.likeCount = likeCount
        self.dislikeCount = dislikeCount
    }
}
