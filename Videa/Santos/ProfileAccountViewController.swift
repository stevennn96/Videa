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
import Kingfisher


class ProfileAccountViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var usernameOutlet: UILabel!
    @IBOutlet weak var quotesOutlet: UILabel!
    
    
    @IBAction func editProfile(_ sender: Any) {
        performSegue(withIdentifier: "EditProfile", sender: self)
    }
    @IBAction func logOutButton(_ sender: Any) {
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "LogOutButton", sender: self)
    }
    var profileuser: [UntukProfile] = []
    
    private var postChildListener: UInt?
    var newProfile: UntukProfile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundImage()
        bacaData()
    }
    
    func bacaData(){
        guard let uid = Auth.auth().currentUser?.uid else{return}
        postChildListener = Database.database().reference().child("users/profile/\(uid)").observe(.value) {(snapshot: DataSnapshot) in
            if snapshot.exists() {
                    let data = snapshot.value as! NSDictionary
                    let key = snapshot.key
                    
                    let username = data["username"] as! String
                    let photoURL = data["photoURL"] as! String
                    let quotesP = data["quotes"] as! String

                    self.usernameOutlet.text = username
                    self.quotesOutlet.text = quotesP
                    self.imageView.kf.setImage(with: URL(string: photoURL), placeholder: nil, options: nil, progressBlock: nil, completionHandler: {image, error, cacheType, imageUrl in }  )
            }
        }
        
    }
    
    func roundImage() {
        self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2
        self.imageView.clipsToBounds = true
//        self.imageView.layer.borderWidth = 10.0
//        self.imageView.layer.borderColor = Color.white.cgColor
//        
    }
}
