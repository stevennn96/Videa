//
//  ChallengeCollectionViewCell.swift
//  Videa
//
//  Created by Kensen Tjoa on 02/10/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit

class ChallengeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var challengeImage: UIImageView!
    @IBOutlet weak var challengeDescription: UILabel!
    
    func setChallenge(challenge: Challenge) {
        
        self.challengeImage.image = challenge.challengeImage
        self.challengeDescription.text = challenge.challengeDescription
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        challengeDescription.sizeToFit()
    }
}
