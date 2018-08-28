//
//  LaunchScreenViewController.swift
//  Videa
//
//  Created by anthony  yaputra on 27/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    @IBOutlet weak var gifBG: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gifBG.loadGif(name: "Videa Animation HD")
        
        let timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)
        // Do any additional setup after loading the view.
        
        
        
        
    }
    
    @objc func timeToMoveOn() {
        self.performSegue(withIdentifier: "SplashScreenToMainMenu", sender: self)
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
