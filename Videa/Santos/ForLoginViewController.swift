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
    @IBOutlet weak var LoginVisualEffectBlur: UIVisualEffectView!
    @IBOutlet weak var LoginbakcgroundImageView: UIImageView!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var backgroundBlurLogin: UIVisualEffectView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loginButton.alpha = 0
        LoginbakcgroundImageView.alpha = 1
        LoginVisualEffectBlur.alpha = 0
        backgroundBlurLogin.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 2.0) {
            self.loginButton.alpha = 1.0
            self.loginButton.center.y -= 30
        }
        UIView.animate(withDuration: 0) {
            self.LoginbakcgroundImageView.alpha = 1.0
        }
        
        UIView.animate(withDuration: 0) {
            self.LoginVisualEffectBlur.alpha = 0
        }
        
        UIView.animate(withDuration: 1) {
            self.backgroundBlurLogin.alpha = 1
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func LoginButton(_ sender: Any) {
        guard let email = emailOutlet.text else {return}
        guard let pass = passwordOutlet.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: pass) {user, error in
            if error == nil && user != nil{
             print("Login Berhasil")
            self.performSegue(withIdentifier: "LoginToProfile", sender: self)
            }else {
                self.errorMessage.text = ("error login \(error!.localizedDescription)")
            }
        }
    }
}
    

