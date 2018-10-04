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
    var destinationTitle: String?
    var destinationNavTitle: String?
    private var postChildListener : UInt?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bacaData()
        
        challengeListTableView.delegate = self
        challengeListTableView.dataSource = self
    }

    func goToDetail() {
        performSegue(withIdentifier: "ChallengeToDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailTableViewController {
            destination.challengeTitle = self.destinationTitle
            destination.navTitle = self.destinationNavTitle
        }
    }
    
    func bacaData() {
        let intro = Challenge(image: UIImage(named: "introduction-1")!, desc: "Perkenalkan Dirimu!")
        introChallenges.append(intro)
        
        let music1 = Challenge(image: UIImage(named: "cover lagu")!, desc: "Cover Lagu dengan Improvisasi")
        musicChallenges.append(music1)
        let music2 = Challenge(image: UIImage(named: "coverlagudenganinstrumentsendiri")!, desc: "Cover Lagu dengan Instrumen Sendiri")
        musicChallenges.append(music2)
        let music3 = Challenge(image: UIImage(named: "coverlagutranslate")!, desc: "Cover Lagu Translate")
        musicChallenges.append(music3)
        let music4 = Challenge(image: UIImage(named: "coverlaguyangsedangtrendy")!, desc: "Cover Lagu yang sedang Trendy")
        musicChallenges.append(music4)
        
        challenges.append(introChallenges)
        challenges.append(musicChallenges)
        
//        guard let uid = Auth.auth().currentUser?.uid
//            else {return}
//        let dataRef = Database.database().reference().child("Fetch/Genre").observe(.value) {(snapshot: DataSnapshot) in
//            if snapshot.exists() {
//                let data = snapshot.value as! NSDictionary
//                let key = snapshot.key
//
//                for i in data {
//
//                    let dataRef2 = Database.database().reference().child("Fetch/Genre/\(i.key)").observe(.value){(snapshot2: DataSnapshot) in
//                        if snapshot2.exists() {
//                            print(i.key)
//
//                            self.genres.append("\(i.key)")
//                            self.challenges.append([])
//                            var y = self.challenges.popLast()
//                            let data2 = snapshot2.value as! NSDictionary
//                            let key2 = snapshot2.key
//
//                            print(data2)
//
//                            for x in data2 {
//
//                                y!.append(Challenge(image: UIImage(named: "Photo Tille Comedy")!, desc: "\(x.key)"))
//                            }
//
//                            self.challenges.append(y!)
//                            print(self.challenges.count)
//                            DispatchQueue.main.async{
//                                self.challengeListTableView.reloadData()
//                                print("Table Reloaded")
//                            }
//                        }
//                    }
//                }
//
//
//
//            }
//
//        }
        
    
    }
}

extension ChallengeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = challengeListTableView.dequeueReusableCell(withIdentifier: "reuseTable") as? ChallengeListTableViewCell
        
        cell?.vc = self
        
        cell?.setChallengeList(challengeList: ChallengeList(title: genres[indexPath.row], collection: challenges[indexPath.row]))
        
        return cell!
    }
    
}
