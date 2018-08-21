//
//  ForLoginViewController.swift
//  Videa
//
//  Created by Sia Feri Santos on 21/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class ForLoginViewController: UIViewController {
    @IBOutlet weak var emailOutlet: UITextField!
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func LoginButton(_ sender: Any) {
        guard let email = emailOutlet.text else {return}
        guard let pass = passwordOutlet.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: pass) {user, error in
            if error == nil && user != nil{
             print("Login Berhasil")
            self.performSegue(withIdentifier: "LoginSucces", sender: self)
            }else {
                self.errorMessage.text = ("error login \(error!.localizedDescription)")
            }
        }
    }
}
    

