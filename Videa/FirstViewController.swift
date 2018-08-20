//
//  FirstViewController.swift
//  Videa
//
//  Created by Steven - on 14/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBAction func introduction(_ sender: Any) {
        performSegue(withIdentifier: "introduction", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

