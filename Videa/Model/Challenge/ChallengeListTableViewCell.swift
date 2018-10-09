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
    var vc: ChallengeViewController?
    
    func setChallengeList(challengeList: ChallengeList) {
        challengeCollection = challengeList.challengeCollection
        challengeTitle.text = challengeList.challengeListTitle
        
        self.challengeCollectionView.reloadData()
//        print("Collection Reloaded")
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
        
        cell?.setChallenge(challenge: Challenge(image: challengeCollection[indexPath.row].challengeImageURL, title: challengeCollection[indexPath.row].challengeTitle, desc1: challengeCollection[indexPath.row].challengeDesc1, desc2: challengeCollection[indexPath.row].challengeDesc2, link: challengeCollection[indexPath.row].challengeVidLink))

        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        vc?.destinationTitle = challengeCollection[indexPath.row].challengeTitle
        vc?.destinationDesc1 = challengeCollection[indexPath.row].challengeDesc1
        vc?.destinationDesc2 = challengeCollection[indexPath.row].challengeDesc2
        vc?.destinationImageURL = challengeCollection[indexPath.row].challengeImageURL
        vc?.destinationVidLink = challengeCollection[indexPath.row].challengeVidLink
        vc?.destinationNavTitle = self.challengeTitle.text
        vc?.goToDetail()
    }
}
