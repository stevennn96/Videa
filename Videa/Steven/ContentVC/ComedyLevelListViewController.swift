//
//  ComedyLevelListViewController.swift
//  Videa
//
//  Created by Steven on 26/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit

class ComedyLevelListViewController: UIViewController {

    @IBOutlet weak var titleImage: UIImageView!
    
    
    var x: Int = 0
    
    @IBAction func chooseChallenge(_ sender: UIButton) {
        x = sender.tag
        performSegue(withIdentifier: "goToChallenge", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ComedyLevelContentViewController{
            destination.tag = x
        }
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
