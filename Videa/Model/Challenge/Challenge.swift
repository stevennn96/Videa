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
    
    var challengeImage: UIImage
    var challengeDescription: String
    
    init(image: UIImage, desc: String) {
        self.challengeImage = image
        self.challengeDescription = desc
    }
}
