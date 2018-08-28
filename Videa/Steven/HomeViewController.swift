//
//  HomeViewController.swift
//  test
//
//  Created by Sia Feri Santos on 22/08/18.
//  Copyright © 2018 Sia Feri Santos. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController{
    
    
    @IBAction func addChallenge(_ sender: Any) {
        performSegue(withIdentifier: "goToChallenges", sender: self)
    }
    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell=tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! HomeTaskTableViewCell
//        let titleLabel =
//        cell.label.text=courseTitle
//        cell.photo.image=Images
//        return cell
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
