//
//  HomeViewController.swift
//  test
//
//  Created by Sia Feri Santos on 22/08/18.
//  Copyright © 2018 Sia Feri Santos. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myChallengeTableView: UITableView!
    
    var selectedChallenge: MyChallenge?
    var myChallenges = [MyChallenge]()
    var largestIndex: Int?
    
    var channelDetail: ChannelDetail?
    var getChannelTask: URLSessionDataTask?
    var urlData: Data?
    var accessToken: String = ""
    
    let blankFiller = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInProcess { (success) in
            if success {
                getAccessToken()
//                getChannelDetail()
            } else {
                print("Damn")
            }
        }
        
        if myChallenges.isEmpty {
            largestIndex = 0
        }
        
        loadChallengeData()
        
        applyLoadingScreen()
        
        myChallengeTableView.delegate = self
        myChallengeTableView.dataSource = self
    }
    
    func fillBlank() {
        
        blankFiller.image = UIImage(named: "HomeBlankFiller")
        blankFiller.frame = CGRect(x: self.view.frame.width/2 - 165, y: self.view.frame.height/2 - 95, width: 330, height: 190)
        self.view.addSubview(blankFiller)
    }
    
    func applyLoadingScreen() {
        
        let loadingImageView = UIImageView()
        let keyWindow = UIApplication.shared.keyWindow
        loadingImageView.tag = 36
        
        DispatchQueue.main.async {
            
            loadingImageView.frame = CGRect(x: 0, y: 0, width: (keyWindow?.frame.width)!, height: (keyWindow?.frame.height)!)
            loadingImageView.image = UIImage(named: "LoadingScreen")
            
            keyWindow?.addSubview(loadingImageView)
        }
    }
    
    func signInProcess(completion: (_ success: Bool) -> Void) {
        if (GIDSignIn.sharedInstance().hasAuthInKeychain()) {
            print("Signed in");
            DispatchQueue.main.async {
                GIDSignIn.sharedInstance()?.signInSilently()
            }
            
        } else {
            print("Not signed in");
            GIDSignIn.sharedInstance()?.signOut()
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }
        
        if GIDSignIn.sharedInstance()?.currentUser != nil {
            completion(true)
        } else {
            completion(false)
        }
    }
    
    func getAccessToken() {
        if GIDSignIn.sharedInstance()?.currentUser != nil {
            print("GIDin")
            accessToken = (GIDSignIn.sharedInstance()?.currentUser.authentication.accessToken)!
            print(accessToken)
        } else {
            print("GIDout")
        }
    }
    
    var quickTipsIndex = 0
    let quickTips = UIButton(type: .custom)
    let keyWindow = UIApplication.shared.keyWindow
    let quickTipsImage = ["QuickTips1", "QuickTips2", "QuickTips3", "QuickTips4", "QuickTips5", "QuickTips6"]
    
    @IBAction func viewQuickTips(_ sender: Any) {
        
        quickTipsIndex = 0
        
        DispatchQueue.main.async {
            
            self.quickTips.frame = CGRect(x: 0, y: 0, width: (self.keyWindow?.frame.width)!, height: (self.keyWindow?.frame.height)!)
            self.quickTips.setImage(UIImage(named: self.quickTipsImage[self.quickTipsIndex]), for: .normal)
            self.quickTips.adjustsImageWhenHighlighted = false
            self.quickTipsIndex += 1
            
            self.keyWindow?.addSubview(self.quickTips)
            for i in (self.keyWindow?.subviews)! {
                print(i)
            }
            
            self.quickTips.addTarget(self, action: #selector(self.quickTipsClicked), for: .touchUpInside)
        }
    }
    
    @objc func quickTipsClicked(_ sender: UIButton) {
        
        if quickTipsIndex < 6 {
            quickTips.setImage(UIImage(named: quickTipsImage[self.quickTipsIndex]), for: .normal)
            self.quickTipsIndex += 1
        } else {
            sender.removeFromSuperview()
        }

    }
    
    @IBAction func addChallenge(_ sender: Any) {
        performSegue(withIdentifier: "HomeToChallenge", sender: nil)
    }
    
    @IBAction func unwindToHome(_ sender: UIStoryboardSegue) {

        if let source = sender.source as? DetailTableViewController {
            
            myChallenges.append(source.theChallenge!)
            myChallenges.removeAll()
            
            guard
                let challengeName = source.theChallenge?.myChallengeTitle,
                let videoLink = source.theChallenge?.myChallengeUrl,
                let viewCount = source.theChallenge?.myChallengeTask.viewCount,
                let viewTarget = source.theChallenge?.myChallengeTask.viewTarget,
                let likeCount = source.theChallenge?.myChallengeTask.likeCount,
                let likeTarget = source.theChallenge?.myChallengeTask.likeTarget,
                let commentCount = source.theChallenge?.myChallengeTask.commentCount,
                let commentTarget = source.theChallenge?.myChallengeTask.commentTarget,
                let index = source.theChallenge?.index
            else {
                return
            }
            
            saveChallengeData(index: index, title: challengeName, videoLink: videoLink, viewCount: viewCount, viewTarget: viewTarget, likeCount: likeCount, likeTarget: likeTarget, commentCount: commentCount, commentTarget: commentTarget) { (success) in
                if success {
                    print("Berhasil")
                } else {
                    print("Error")
                }
            }
            
            myChallengeTableView.reloadData()
        }
        
        if let source = sender.source as? TaskViewController {
            
        }
    }
    
    func saveChallengeData(index: Int, title: String, videoLink: String, viewCount: Int, viewTarget: Int, likeCount: Int, likeTarget: Int, commentCount: Int, commentTarget: Int, completion: @escaping ((_ success: Bool)->())) {
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let databaseRef = Database.database().reference().child("users/challengeJoined/\(uid)/\(title)")
        
        let saveChallenge = [
            "index": index,
            "videoLink": videoLink,
            "viewCount": viewCount,
            "viewTarget": viewTarget,
            "likeCount": likeCount,
            "likeTarget": likeTarget,
            "commentCount": commentCount,
            "commentTarget": commentTarget
            ] as [String : Any]
        
        databaseRef.setValue(saveChallenge) { (error, ref) in
            completion(error == nil)
        }
    }
    
    func loadChallengeData() {
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let ref = Database.database().reference().child("users/challengeJoined/\(uid)").queryOrdered(byChild: "index")
        let dataRef = ref.observe(.value) { (snapshot: DataSnapshot) in
            if snapshot.exists() {
                self.myChallenges.removeAll()
                for i in snapshot.children.allObjects as! [DataSnapshot] {
                    let data = i.value
                    let key = i.key
                    
                    print("C \(snapshot.children.allObjects.count)")
                    let ref2 = Database.database().reference().child("users/challengeJoined/\(uid)/\(key)")
                    let dataRef2 = ref2.observe(.value, with: { (snapshot2: DataSnapshot) in
                        if snapshot2.exists() {
                            
                            if snapshot.children.allObjects.count == 1 {
                                self.myChallenges.removeAll()
                            }
                            
                            let data2 = snapshot2.value as! NSDictionary
                            let key2 = snapshot2.key
                            
                            let title = key2
                            let viewCount = data2["viewCount"] as! Int
                            let viewTarget = data2["viewTarget"] as! Int
                            let likeCount = data2["likeCount"] as! Int
                            let likeTarget = data2["likeTarget"] as! Int
                            let commentCount = data2["commentCount"] as! Int
                            let commentTarget = data2["commentTarget"] as! Int
                            let videoLink = data2["videoLink"] as! String
                            let index = data2["index"] as! Int
                            
                            var status = 0
                            if viewCount >= viewTarget {
                                status += 1
                            }
                            if likeCount >= likeTarget {
                                status += 1
                            }
                            if commentCount >= commentTarget {
                                status += 1
                            }
                            
                            print(title)
                            
                            let task = Task(viewTarget: viewTarget, viewCount: viewCount, likeTarget: likeTarget, likeCount: likeCount, commentTarget: commentTarget, commentCount: commentCount)
                            
                            let newChallenge = MyChallenge(title: title, url: videoLink, status: status, task: task, index: index)
                            self.myChallenges.insert(newChallenge, at: 0)
                            print(newChallenge)
                            DispatchQueue.main.async {
                                self.blankFiller.removeFromSuperview()
                                print("A \(self.myChallenges.count)")
                                self.myChallengeTableView.reloadData()
                            }
                        } else {
                            self.myChallenges.removeAll()
                            self.fillBlank()
                            print("B \(self.myChallenges.count)")
                            self.myChallengeTableView.reloadData()
                        }
                    })
                }
            } else {
                self.myChallenges.removeAll()
                self.fillBlank()
                print("D \(self.myChallenges.count)")
                self.myChallengeTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myChallenges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myChallengeTableView.dequeueReusableCell(withIdentifier: "reuseMyChallenge") as! MyChallengeTableViewCell
        
        cell.setMyChallenge(myChallenge: MyChallenge(title: myChallenges[indexPath.row].myChallengeTitle, url: myChallenges[indexPath.row].myChallengeUrl, status: myChallenges[indexPath.row].myChallengeStatus, task: myChallenges[indexPath.row].myChallengeTask, index: myChallenges[indexPath.row].index))
        
        self.largestIndex = self.myChallenges.first!.index
        print("Index \(self.largestIndex!)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedChallenge = myChallenges[indexPath.row]
        performSegue(withIdentifier: "HomeToTask", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? TaskViewController {
            destination.myChallenge = selectedChallenge
        }
        
        if let destination = segue.destination as? ChallengeViewController {
            destination.largestIndex = largestIndex
            print("Home \(largestIndex!)")
        }
    }
}
