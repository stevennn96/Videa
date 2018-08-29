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


class ProfileAccountViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    @IBOutlet weak var achievementCollectionView: UICollectionView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var usernameOutlet: UILabel!
    @IBOutlet weak var quotesOutlet: UILabel!
    @IBOutlet weak var levelOutlet: UILabel!
    
        let array: [String] = ["like 500 lock", "like3k lock", "like5k lock", "like10k lock", "sub1k lock", "sub1mi lock", "sub2k lock", "sub5k lock", "sub100k lock", "comment1 lock", "comment5 lock", "comment10 lock", "comment500 lock", "music5 lock", "music10 lock", "comedy5 lock", "comedy10 lock", "food5 lock", "food10 lock", "howto5 lock", "howto10 lock"]
    
    let arrayLbl: [String] = ["Reach 500 Likes", "Reach 3K Likes", "Reach 5K Likes", "Reach 10K Likes", "Reach 1K Subs", "Reach 1 Mil subs", "Reach 2K Subs", "Reach 5K Subs", "Reach 100K Subs", "Reach 1 Comment", "Reach 5 Comment", "Reach 10 Comment", "Reach 500 Comment", "Complete 5 Music Challenge", "Complete 10 Music Challenge", "Complete 5 Comedy Challenge", "Complete 10 Comedy Challenge", "Complete 5 Food Challenge", "Complete 10 Food Challenge", "Complete 5 How To Challenge", "Complete 10 How To Challenge"]
    
    
    @IBAction func editProfile(_ sender: Any) {
        performSegue(withIdentifier: "EditProfile", sender: self)
    }
    
    var profileuser: [UntukProfile] = []
    var gamnification: [gamificationData] = []
    
    private var postChildListener: UInt?
    private var postChild: UInt?
    
    var newProfile: UntukProfile?
    var newGamification: gamificationData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Buat ganti warna title navigation bar
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
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

