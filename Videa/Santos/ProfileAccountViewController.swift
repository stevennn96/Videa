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
    @IBOutlet weak var tapTochangeImage: UIButton!
    @IBOutlet weak var levelOutlet: UILabel!
    
    @IBAction func segueA(_ sender: Any) {
        performSegue(withIdentifier: "Coba", sender: self)
    }
    
    
    @IBAction func editProfile(_ sender: Any) {
        performSegue(withIdentifier: "EditProfile", sender: self)
    }
    @IBAction func logOutButton(_ sender: Any) {
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "LogOut", sender: self)
    }
    var profileuser: [UntukProfile] = []
    var gamnification: [gamificationData] = []
    
    private var postChildListener: UInt?
    private var postChild: UInt?
    
    var newProfile: UntukProfile?
    var newGamification: gamificationData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundImage()
        bacaLevel()
        bacaData()
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.layer.cornerRadius = imageView.frame.size.height/2
        imageView.clipsToBounds = true
    }
    func bacaLevel() {
        guard let uid = Auth.auth().currentUser?.uid else{return}
        postChild = Database.database().reference().child("Gamification/user/\(uid)").observe(.value) {(snapshot: DataSnapshot)in
            if snapshot.exists() {
                let data = snapshot.value as! NSDictionary
                let key = snapshot.key
                
                let levelUser = data["levelUser"] as! String
                
                self.levelOutlet.text = "Lv \(levelUser)"
            }
        }
        
        
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
    }
}
