//
//  GIDSignInViewController.swift
//  Videa
//
//  Created by Kensen Tjoa on 11/10/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class GIDSignInViewController: UIViewController, GIDSignInUIDelegate {

    @IBAction func signInGoogle(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.uiDelegate = self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
