//
//  LoginViewController.swift
//  Videa
//
//  Created by Sia Feri Santos on 20/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var emailOutlet: UITextField!
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var errorMessage: UILabel!

    @IBAction func registerSucces(_ sender: Any) {
        guard let username = usernameOutlet.text else {return}
        guard let email = emailOutlet.text else {return}
        guard let password = passwordOutlet.text else {return}
        Auth.auth().createUser(withEmail: email, password: password) {user, error in
            if error == nil && user != nil {
                print("Membuat Akun")
                let changerequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changerequest?.displayName = username
                changerequest?.commitChanges {erorr in
                    if error == nil {
                    print("username Changed")
                    }else {
                        print("Error: \(error!.localizedDescription)")
                    }
            }
               self.performSegue(withIdentifier: "RegisterSucces", sender: self)
        } else {
                self.errorMessage.text = ("Error: \(error!.localizedDescription)")
    }
            
}
        
}
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}
