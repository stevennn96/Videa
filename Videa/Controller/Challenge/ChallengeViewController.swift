//
//  ChallengeViewController.swift
//  Videa
//
//  Created by Kensen Tjoa on 02/10/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ChallengeViewController: UIViewController {

    @IBOutlet weak var challengeListTableView: UITableView!
    
    var genres = ["Introduction", "Music"]
    var challenges = [[Challenge]]()
    var introChallenges = [Challenge]()
    var musicChallenges = [Challenge]()
    private var postChildListener : UInt?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bacaData()
        
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

    func bacaData() {
    guard let uid = Auth.auth().currentUser?.uid
        else {return}
        let dataRef = Database.database().reference().child("Fetch/Genre").observe(.value) {(snapshot: DataSnapshot) in
            if snapshot.exists() {
                let data = snapshot.value as! NSDictionary
                let key = snapshot.key

                for i in data {
//                    print("\(i.key)")
                    let dataRef2 = Database.database().reference().child("Fetch/Genre/\(i.key)").observe(.value){(snapshot2: DataSnapshot) in
                        if snapshot2.exists() {
                            let data2 = snapshot2.value as! NSDictionary
                            let key2 = snapshot2.key
                            
                            print(data2.value(forKey: "JudulChallenge"))
                            
                            
                        }
                    }
                }
                

                
            }
            
        }
        
    
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
