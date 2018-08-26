//
//  ChallengesListViewController.swift
//  Videa
//
//  Created by Steven on 26/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit

class ChallengesListViewController: UIViewController {

    @IBAction func introduction(_ sender: Any) {
        performSegue(withIdentifier: "goToIntroduction", sender: self)
    }
    
    @IBAction func music(_ sender: Any) {
        performSegue(withIdentifier: "goToMusic", sender: self)
    }
    
    @IBAction func comedy(_ sender: Any) {
        performSegue(withIdentifier: "goToComedy", sender: self)
    }
    
    @IBAction func food(_ sender: Any) {
        performSegue(withIdentifier: "goToFood", sender: self)
    }
    
    @IBAction func howTo(_ sender: Any) {
        performSegue(withIdentifier: "goToHowTo", sender: self)
    }
    
    
    
    
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
