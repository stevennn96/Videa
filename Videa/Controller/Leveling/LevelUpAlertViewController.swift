//
//  LevelUpAlertViewController.swift
//  Videa
//
//  Created by Kensen Tjoa on 28/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit

class LevelUpAlertViewController: UIViewController {

    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBAction func okButtonPressed(_ sender: Any) {
        print("asd")
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.alertView.frame = CGRect(x: 67, y: 52, width: 240, height: 128)
        
        self.descriptionLabel.text = "You are now level \(level)!"
        
//        UIView.transition(with: self.view, duration: 2.0, options: .curveEaseOut, animations: {
//            self.view.alpha = 0
//        }) { (finished) in
//            self.alertView.frame = CGRect(x: 67, y: 342, width: 240, height: 128)
//        }
        
//        UIView.animate(withDuration: 10) {
//            self.alertView.frame = CGRect(x: 67, y: 342, width: 240, height: 128)
//        }
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
