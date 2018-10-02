//
//  Challenge.swift
//  Videa
//
//  Created by Kensen Tjoa on 02/10/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import Foundation
import UIKit

class ChallengeList {
    
    var challengeListTitle: String
    var challengeCollection = [Challenge]()
    
    init(title: String, collection: [Challenge]) {
        self.challengeListTitle = title
        self.challengeCollection = collection
    }
}
