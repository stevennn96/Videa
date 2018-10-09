//
//  MyChallenge.swift
//  Videa
//
//  Created by Kensen Tjoa on 08/10/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import Foundation

class MyChallenge {
    
    var myChallengeTitle: String
    var myChallengeUrl: String
    var myChallengeStatus: Int
    
    init(title: String, url: String, status: Int) {
        self.myChallengeTitle = title
        self.myChallengeUrl = url
        self.myChallengeStatus = status
    }
}
