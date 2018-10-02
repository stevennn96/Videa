//
//  ChallengeTableViewCell.swift
//  Videa
//
//  Created by Kensen Tjoa on 02/10/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit

class ChallengeListTableViewCell: UITableViewCell {

    @IBOutlet weak var challengeTitle: UILabel!
    @IBOutlet weak var challengeCollectionView: UICollectionView!
    var challengeCollection = [Challenge]()
    
    func setChallengeList(challengeList: ChallengeList) {
        challengeCollection = challengeList.challengeCollection
        challengeTitle.text = challengeList.challengeListTitle
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        challengeCollectionView.delegate = self
        challengeCollectionView.dataSource = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension ChallengeListTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return challengeCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = challengeCollectionView.dequeueReusableCell(withReuseIdentifier: "reuseCollection", for: indexPath) as? ChallengeCollectionViewCell
        
        cell?.setChallenge(challenge: Challenge(image: challengeCollection[indexPath.row].challengeImage, desc: challengeCollection[indexPath.row].challengeDescription))
        
        return cell!
    }
    
    
}
