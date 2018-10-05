//
//  ChallengeCollection.swift
//  Videa
//
//  Created by Kensen Tjoa on 02/10/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import Foundation
import UIKit

class Challenge {
    
    var challengeImageURL: String
    var challengeTitle: String
    var challengeDesc1: String
    var challengeDesc2: String
    var challengeVidLink: String
    
    init(image: String, title: String, desc1: String, desc2: String, link: String) {
        self.challengeImageURL = image
        self.challengeTitle = title
        self.challengeDesc1 = desc1
        self.challengeDesc2 = desc2
        self.challengeVidLink = link
    }
}
