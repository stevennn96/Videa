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
import Kingfisher

class ChallengeViewController: UIViewController {

    @IBOutlet weak var challengeListTableView: UITableView!
    
    var genres = [String]()
    var challenges = [[Challenge]]()
    var introChallenges = [Challenge]()
    var musicChallenges = [Challenge]()
    var destinationTitle: String?
    var destinationNavTitle: String?
    var destinationDesc1: String?
    var destinationDesc2: String?
    var destinationImageURL: String?
    var destinationVidLink: String?
    
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
            destination.desc1 = self.destinationDesc1
            destination.desc2 = self.destinationDesc2
            destination.imageURL = self.destinationImageURL
            destination.vidLink = self.destinationVidLink
        }
    }
    
    func bacaData() {
        
        let dataRef = Database.database().reference().child("Fetch/Genre").observe(.value) {(snapshot: DataSnapshot) in
            if snapshot.exists() {
                let data = snapshot.value as! NSDictionary
                let key = snapshot.key

                for i in data {
                    self.genres.append("\(i.value)")

                    let dataRef2 = Database.database().reference().child("Fetch/ListChallenge/\(i.key)").observe(.value) {(snapshot2: DataSnapshot) in
                        if snapshot2.exists() {
                            let data2 = snapshot2.value as! NSArray
                            let key2 = snapshot2.key

                            var x = [NSDictionary]()
                            for j in data2 {
                                if j is NSNull {
                                    continue
                                }
                                x.append(j as! NSDictionary)
                            }

                            var data3 = Dictionary<String, Any>()
                            for v in x {
                                let keyv = v.allKeys[0]
                                let value = v.allValues[0]
                                data3.updateValue(value, forKey: keyv as! String)
                            }
                            
                            print("DICT")
                            self.challenges.append([])
                            var newChallenges = self.challenges.popLast()
                            for d in data3 {
                                let dc = d.value as! NSDictionary
                                let challengeTitle = d.key
                                let challengeDesc1 = dc["Deskripsi1"] as! String
                                let challengeDesc2 = dc["Deskripsi2"] as! String
                                let challengeLink = dc["VideoLink"] as! String
                                let newChallenge = Challenge(image: "cover lagu", title: challengeTitle, desc1: challengeDesc1, desc2: challengeDesc2, link: challengeLink)
                                newChallenges?.append(newChallenge)
                            }
                            self.challenges.append(newChallenges!)
                            
                            print("Snapshot2 Exists")
                            print("C \(self.challenges.count)")
                            print("G \(self.genres.count)")
                            
                            if self.challenges.count == self.genres.count {
                                DispatchQueue.main.async {
                                    self.challengeListTableView.reloadData()
                                }
                            }
                        }
                        print("dataref2")
                        print("C \(self.challenges.count)")
                        print("G \(self.genres.count)")
                    }
                    print("for i in data")
                    print("C \(self.challenges.count)")
                    print("G \(self.genres.count)")
                }
                print("Snapshot Exists")
                print("C \(self.challenges.count)")
                print("G \(self.genres.count)")
            }
        }
        print("Baca Data")
        print("C \(self.challenges.count)")
        print("G \(self.genres.count)")
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
