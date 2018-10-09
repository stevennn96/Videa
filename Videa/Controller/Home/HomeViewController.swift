//
//  HomeViewController.swift
//  test
//
//  Created by Sia Feri Santos on 22/08/18.
//  Copyright © 2018 Sia Feri Santos. All rights reserved.
//

import UIKit

var tasks: [Task] = []
var level: Int = 1
var currXp: Int = 0
var maxXp: Int = 50

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myChallengeTableView: UITableView!
    var myChallenges = [MyChallenge]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myChallengeTableView.delegate = self
        myChallengeTableView.dataSource = self
    }
    
    @IBAction func addChallenge(_ sender: Any) {
        performSegue(withIdentifier: "HomeToChallenge", sender: nil)
    }
    
    @IBAction func unwindToHome(_ sender: UIStoryboardSegue) {
        if let source = sender.source as? DetailTableViewController {
            myChallenges.append(source.theChallenge!)
            myChallengeTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myChallenges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = myChallengeTableView.dequeueReusableCell(withIdentifier: "reuseMyChallenge") as! MyChallengeTableViewCell
        
        cell.setMyChallenge(myChallenge: MyChallenge(title: myChallenges[indexPath.row].myChallengeTitle, url: myChallenges[indexPath.row].myChallengeUrl, status: myChallenges[indexPath.row].myChallengeStatus))
        
        return cell
    }
}
