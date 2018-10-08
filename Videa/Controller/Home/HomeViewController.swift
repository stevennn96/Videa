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

class HomeViewController: UIViewController {
    
    @IBAction func addChallenge(_ sender: Any) {
        performSegue(withIdentifier: "HomeToChallenge", sender: nil)
    }
    
    @IBAction func unwindToHome(_ sender: UIStoryboardSegue) {
        
    }
}
