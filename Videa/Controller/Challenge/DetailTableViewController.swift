//
//  DetailTableViewController.swift
//  Videa
//
//  Created by Kensen Tjoa on 03/10/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit
import WebKit

class DetailTableViewController: UITableViewController {

    var challengeTitle: String?
    var navTitle: String?
    var desc1: String?
    var desc2: String?
    var vidLink: String?
    var imageURL: String?
    
    @IBOutlet weak var desc1TextView: UITextView!
    @IBOutlet weak var desc2TextView: UITextView!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var youtubeVideoWebView: UIWebView!
    var joinButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("D1 \(desc1)")
        print("D2 \(desc2)")
        titleTextView.text = challengeTitle
        self.navigationItem.title = navTitle
        desc1TextView.text = desc1
        desc2TextView.text = desc2
        
//        "https://www.youtube.com/embed/RmHqOSrkZnk"
        
        print("VL \(vidLink)")
        let url = URL(string: "\(vidLink!)")
        youtubeVideoWebView.loadRequest(URLRequest(url: url!))
        
        self.joinButton = UIButton(type: .custom)
        self.joinButton!.addTarget(self, action: #selector(joinButtonClicked), for: .touchUpInside)
        self.navigationController?.view.addSubview(self.joinButton!)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
        
        print(self.joinButton)
    }
    
    override func viewWillLayoutSubviews() {
        self.joinButton!.clipsToBounds = true
        self.joinButton!.setImage(UIImage(named: "JoinChallenge"), for: .normal)
        self.joinButton?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.joinButton!.centerXAnchor.constraint(equalTo: self.view.centerXAnchor), (self.joinButton?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20))!])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        self.joinButton!.removeFromSuperview()
    }
    
    @objc func joinButtonClicked(_sender: UIButton) {
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 {
            return 210
        } else if indexPath.row == 4{
            return 80
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 5
//    }

//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//
//        return cell
//    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
