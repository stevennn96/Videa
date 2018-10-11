//
//  Task.swift
//  Videa
//
//  Created by Kensen Tjoa on 28/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import Foundation

class Task{
    
    var viewTarget: Int?
    var viewCount: Int?
    var likeTarget: Int?
    var likeCount: Int?
    var commentTarget: Int?
    var commentCount: Int?
    
    init(viewTarget: Int, viewCount: Int, likeTarget: Int, likeCount: Int, commentTarget: Int, commentCount: Int) {
        self.viewTarget = viewTarget
        self.viewCount = viewCount
        self.likeTarget = likeTarget
        self.likeCount = likeCount
        self.commentTarget = commentTarget
        self.commentCount = commentCount
    }
}
