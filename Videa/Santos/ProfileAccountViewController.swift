//
//  ProfileAccountViewController.swift
//  Videa
//
//  Created by Sia Feri Santos on 27/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ProfileAccountViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var usernameOutlet: UILabel!
    
    @IBAction func logOutButton(_ sender: Any) {
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "LogOutButton", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        

    }
}
