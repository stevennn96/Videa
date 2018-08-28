//
//  LevelViewController.swift
//  Videa
//
//  Created by Kensen Tjoa on 28/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit

var level: Int = 0
var currXp: Int = 0
var maxXp: Int = 75

class LevelViewController: UIViewController {

    @IBOutlet weak var viewAlert: UIView!
    @IBOutlet weak var viewBgAlert: UIView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var xpLabel: UILabel!
    @IBOutlet weak var levelBar: UIProgressView!
    
    var alert: UIAlertController?
    
    @IBAction func plusXp(_ sender: Any) {
        
        currXp += 25
//        levelBar.progress += Float(currXp)/Float(maxXp)
        
        if currXp >= maxXp {
            
            self.levelBar.progress = 0
            
            currXp = currXp - maxXp
            maxXp += 25
            level += 1
            
            viewBgAlert.isHidden = false
                UIView.transition(with: viewAlert, duration: 1, options: .curveEaseOut, animations: {
                    
                    self.viewAlert.frame.origin = CGPoint(x: self.view.frame.width/2 - self.viewAlert.frame.width/2, y: self.view.frame.height/3)
                    
                }, completion: nil)
            
        }
        
        self.levelBar.progress = Float(currXp)/Float(maxXp)
        
        self.levelLabel.text = "Lv \(level)"
        self.xpLabel.text = "XP \(currXp)/\(maxXp)"
    }
    
    @IBAction func dismissClicked(_ sender: Any) {
        UIView.transition(with: viewAlert, duration: 1, options: .curveEaseOut, animations: {
            
            self.viewAlert.frame.origin = CGPoint(x: self.view.frame.width/2 - self.viewAlert.frame.width/2, y: self.view.frame.origin.y - self.viewAlert.frame.height)
            
        }, completion: { (false) in
            self.viewBgAlert.isHidden = true
        })
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.levelBar.progress = 0
        viewBgAlert.isHidden = true
        level = 1
        currXp = 0
        maxXp = 75
        
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
