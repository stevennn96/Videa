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

var username1: String?

class ProfileAccountViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    @IBOutlet weak var achievementCollectionView: UICollectionView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var usernameOutlet: UILabel!
    @IBOutlet weak var quotesOutlet: UILabel!
    @IBOutlet weak var levelOutlet: UILabel!
    @IBOutlet weak var levelProgressBar: UIProgressView!
    
    var array = [String]()
    
    let arrayLbl: [String] = ["Reach 1K Subs", "Reach 2K Subs", "Reach 5K Subs", "Reach 100K Subs", "Reach 1 Mil subs"]
    
    
    @IBAction func editProfile(_ sender: Any) {
        performSegue(withIdentifier: "EditProfile", sender: self)
    }
    
    var profileuser: [UntukProfile] = []
    var gamnification: [gamificationData] = []
    
    private var postChildListener: UInt?
    private var postChild: UInt?
    private var postChild2: UInt?
    
    var newProfile: UntukProfile?
    var newGamification: gamificationData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let subCount = GIDSignedInUser.channelDetail?.items![0].statistics?.subscriberCount
        
        guard let intSub = Int(subCount!) else {return}
        
        if intSub >= 1000 {
            array.append("sub1k")
        } else {
            array.append("sub1klock")
        }
        
        if intSub >= 2000 {
            array.append("sub2k")
        } else {
            array.append("sub2klock")
        }
        
        if intSub >= 5000 {
            array.append("sub5k")
        } else {
            array.append("sub5klock")
        }
        
        if intSub >= 100000 {
            array.append("sub100k")
        } else {
            array.append("sub100klock")
        }
        
        if intSub >= 1000000 {
            array.append("sub1mi")
        } else {
            array.append("sub1milock")
        }
        
        //progress bar size and color
        levelProgressBar.transform = levelProgressBar.transform.scaledBy(x: 1, y: 3)
        levelProgressBar.progressTintColor = UIColor.orange
        
        //Buat ganti warna title navigation bar
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        //Back Button Color
        self.navigationController?.navigationBar.tintColor = UIColor.white
        bacaUsername()
        roundImage()
        bacaLevel()
        bacaData()
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.layer.cornerRadius = imageView.frame.size.height/2
        imageView.clipsToBounds = true
        
        let itemSize = UIScreen.main.bounds.width/3-3
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(20, 0, 10, 0)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "settingsIcon"), style: .plain, target: nil, action: #selector(toSettings))
    }
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "ProfileToSettings", sender: nil)
    }
    
    @IBAction func unwindToProfileAccount(_ sender: UIStoryboardSegue){
        
    }
    
    func bacaLevel() {
        guard let uid = Auth.auth().currentUser?.uid else{return}
        postChild = Database.database().reference().child("users/level/\(uid)").observe(.value) {(snapshot: DataSnapshot)in
            if snapshot.exists() {
                let data = snapshot.value as! NSDictionary
                let key = snapshot.key
                
                let levelUser = data["level"]
                
                DispatchQueue.main.async {
                    self.levelOutlet.text = "Lv \(levelUser!)"
                }
            } else {
                DispatchQueue.main.async {
                    self.levelOutlet.text = "Lv 1"
                }
            }
        }
    }
    
    //Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! achievementCell
            cell.imageView.image = UIImage(named: array[indexPath.row] + ".PNG")
            cell.achievementLabel.text = arrayLbl[indexPath.row]
        return cell
    }
    
    func bacaUsername() {
        guard let uid = Auth.auth().currentUser?.uid else{return}
        postChild2 = Database.database().reference().child("Data User/\(uid)").observe(.value) { (snapshot: DataSnapshot) in
            
            if snapshot.exists() {
                let data = snapshot.value as! NSDictionary
                let key = snapshot.key
                
                username1 = data["username"] as! String
                self.usernameOutlet.text = username1
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

