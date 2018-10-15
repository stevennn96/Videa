//
//  MyChallengesTableViewCell.swift
//  Videa
//
//  Created by Kensen Tjoa on 08/10/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit

class MyChallengeTableViewCell: UITableViewCell {

    @IBOutlet weak var challengeCardImageView: UIImageView!
    @IBOutlet weak var challengeTitleLabel: UILabel!
    @IBOutlet weak var challengeStatusLabel: UILabel!
    @IBOutlet weak var challengeStatusImageView: UIImageView!
    
    func setMyChallenge(myChallenge: MyChallenge) {
        
        challengeTitleLabel.text = myChallenge.myChallengeTitle
        challengeStatusLabel.text = "\(myChallenge.myChallengeStatus) dari 3 tugas terselesaikan"
        challengeStatusImageView.image = UIImage(named: "\(myChallenge.myChallengeStatus) of 3")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
