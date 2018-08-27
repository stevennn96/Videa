//
//  LoginAccountViewController.swift
//  Videa
//
//  Created by Sia Feri Santos on 21/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class LoginAccountViewController: UIViewController {
    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var emailOutlet: UITextField!
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var VisualEffectBlur: UIVisualEffectView!
    @IBOutlet weak var registerButtonOutlet: UIButton!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        backgroundImageView.alpha = 1
        registerButtonOutlet.alpha = 0.0
        VisualEffectBlur.alpha = 0.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 1.0) {
            self.backgroundImageView.alpha = 1.0
        }
        
        UIView.animate(withDuration: 2.0) {
            self.VisualEffectBlur.alpha = 0.8
        }
        
        UIView.animate(withDuration: 2.0) {
            self.registerButtonOutlet.alpha = 1.0
            self.registerButtonOutlet.center.y -= 30
        }
        
        
    }

    @IBAction func registerSucces(_ sender: Any) {
        guard let username = usernameOutlet.text else {return}
        guard let email = emailOutlet.text else {return}
        guard let password = passwordOutlet.text else {return}
        Auth.auth().createUser(withEmail: email, password: password) {user, error in
            if error == nil && user != nil {
                print("Membuat Akun")
                
                let changerequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changerequest?.displayName = username
                changerequest?.commitChanges {error in
                    if error == nil {
                        print("username Changed")
                        
                        self.saveUsernameAndPassword(username: username, email: email, password: password) { succes in
                            if succes {
                                print("Berhasil")
                                
                            }
                            
                        }
                    }else {
                        print("Error: \(error!.localizedDescription)")
                    }
                }
                self.performSegue(withIdentifier: "RegisterSuccess", sender: self)
            } else {
                self.errorMessage.text = ("Error: \(error!.localizedDescription)")
            }
            
        }
        
    }
    
    @IBAction func registerToLogin(_ sender: Any) {
        performSegue(withIdentifier: "RegisterSuccess", sender: nil)
    }
    
    func saveUsernameAndPassword(username: String, email: String, password:String, completion : @escaping ((_ success:Bool)->())) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let databaseRef = Database.database().reference().child("Data User/\(uid)")
        
        let userData = [
            "username" : username,
            "email" : email,
            "password" : password,
            "timestamp" : [".sv":"timestamp"]
        ]as [String:Any]
        databaseRef.setValue(userData) { error, ref in
            completion(error == nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}
