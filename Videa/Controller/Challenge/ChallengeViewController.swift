//
//  ChallengeViewController.swift
//  Videa
//
//  Created by Kensen Tjoa on 02/10/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit

class ChallengeViewController: UIViewController {

    @IBOutlet weak var challengeListTableView: UITableView!
    
    var genres = ["Introduction", "Music"]
    var challenges = [[Challenge]]()
    var introChallenges = [Challenge]()
    var musicChallenges = [Challenge]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let intro = Challenge(image: UIImage(named: "introduction-1")!, desc: "Perkenalkan Dirimu!")
        introChallenges.append(intro)
        
        let music1 = Challenge(image: UIImage(named: "coverlagudenganimprovisasi")!, desc: "Cover Lagu dengan Improvisasi")
        musicChallenges.append(music1)
        let music2 = Challenge(image: UIImage(named: "coverlagudenganinstrumentsendiri")!, desc: "Cover Lagu dengan Instrumen Sendiri")
        musicChallenges.append(music2)
        let music3 = Challenge(image: UIImage(named: "coverlagutranslate")!, desc: "Cover Lagu Translate")
        musicChallenges.append(music3)
        let music4 = Challenge(image: UIImage(named: "coverlaguyangsedangtrendy")!, desc: "Cover Lagu yang sedang Trendy")
        musicChallenges.append(music4)
        
        challenges.append(introChallenges)
        challenges.append(musicChallenges)
        
        challengeListTableView.delegate = self
        challengeListTableView.dataSource = self
    }

}

extension ChallengeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = challengeListTableView.dequeueReusableCell(withIdentifier: "reuseTable") as? ChallengeListTableViewCell
        
        cell?.setChallengeList(challengeList: ChallengeList(title: genres[indexPath.row], collection: challenges[indexPath.row]))
        
        return cell!
    }
    
    
}
