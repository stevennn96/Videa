//
//  ChallengeCollectionViewCell.swift
//  Videa
//
//  Created by Kensen Tjoa on 02/10/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit
import Kingfisher

class ChallengeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var challengeImage: UIImageView!
    @IBOutlet weak var challengeDescription: UITextView!
    
    func setChallenge(challenge: Challenge) {
        
        self.challengeImage.image = UIImage(named: "\(challenge.challengeImageURL)")
        self.challengeImage.kf.setImage(with: URL(string: challenge.challengeImageURL), placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacheType, imageUrl) in
            
        }
        self.challengeDescription.text = challenge.challengeTitle
        self.challengeDescription.textContainer.lineFragmentPadding = 0
        self.challengeDescription.textContainerInset = .zero
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
