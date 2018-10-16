//
//  TaskViewController.swift
//  Videa
//
//  Created by Kensen Tjoa on 10/10/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit
import WebKit
import Firebase
import FirebaseAuth

class TaskViewController: UIViewController {

    @IBOutlet weak var guideLabel: UILabel!
    @IBOutlet weak var challengeTitleLabel: UITextView!
    @IBOutlet weak var videoWebView: UIWebView!
    @IBOutlet weak var viewLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var videoNameLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var chooseVideoButton: UIButton!
    @IBOutlet weak var deleteChallengeButton: UIBarButtonItem!
    
    var videoDetail: VideoDetail?
    var myChallenge: MyChallenge?
    
    @IBOutlet weak var viewTickImageView: UIImageView!
    @IBOutlet weak var likeTickImageView: UIImageView!
    @IBOutlet weak var commentTickImageView: UIImageView!
    
    var apiKey = "AIzaSyA614LZH2YQaHu3_hyXnEkOq2d9p0Bd0x8"
    
    var challengeTitle: String?
    var viewCount: Int?
    var viewTarget: Int?
    var likeCount: Int?
    var likeTarget: Int?
    var commentCount: Int?
    var commentTarget: Int?
    var videoUrl: String?
    
    let transView = UIView()
    
    @IBAction func chooseVideo(_ sender: Any) {
        performSegue(withIdentifier: "TaskToMyVideo", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        challengeTitle = myChallenge?.myChallengeTitle
        viewCount = myChallenge?.myChallengeTask.viewCount
        viewTarget = myChallenge?.myChallengeTask.viewTarget
        likeCount = myChallenge?.myChallengeTask.likeCount
        likeTarget = myChallenge?.myChallengeTask.likeTarget
        commentCount = myChallenge?.myChallengeTask.commentCount
        commentTarget = myChallenge?.myChallengeTask.commentTarget
        videoUrl = myChallenge?.myChallengeUrl
        
        challengeTitleLabel.text = challengeTitle
        viewLabel.text = "Dapat \(viewCount!) / \(viewTarget!) Views"
        likeLabel.text = "Dapat \(likeCount!) / \(likeTarget!) Likes"
        commentLabel.text = "Dapat \(commentCount!) / \(commentTarget!) Comments"
        
        if videoUrl != "" {
            loadChallenge()
        } else {
            guideLabel.isHidden = false
            submitButton.isEnabled = false
        }
    }
    
    func loadChallenge() {
        
        let url = URL(string: videoUrl!)
        videoWebView.loadRequest(URLRequest(url: url!))
        
        let apiUrl = URL(string: "https://www.googleapis.com/youtube/v3/videos?key=\(apiKey)&id=\(videoUrl!.youtubeID!)&part=snippet,contentDetails,statistics")
        
        let getVideoTask = URLSession.shared.dataTask(with: apiUrl!) { (data, response, error) in
            do {
                self.videoDetail = try JSONDecoder().decode(VideoDetail.self, from: data!)
            } catch let error as NSError {
                print(error)
            }
            
            DispatchQueue.main.async {
                self.videoNameLabel.text = self.videoDetail?.items![0].snippet?.title
                self.checkTick(type: 0)
                self.guideLabel.isHidden = true
            }
        }
        getVideoTask.resume()
    }
    
    func checkTick(type: Int) {
        
        var status = 0
        
        if self.viewCount! >= self.viewTarget! {
            self.viewTickImageView.isHidden = false
            status += 1
        }
        if self.likeCount! >= self.likeTarget! {
            self.likeTickImageView.isHidden = false
            status += 1
        }
        if self.commentCount! >= self.commentTarget! {
            self.commentTickImageView.isHidden = false
            status += 1
        }
        
        if status == 3 {
            chooseVideoButton.isEnabled = false
            submitButton.isEnabled = false
            deleteChallengeButton.isEnabled = false
            
            if type == 1 {
                
                let levelUp = UIButton(type: .custom)
                let keyWindow = UIApplication.shared.keyWindow
                
                transView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                transView.alpha = 0.5
                transView.frame = CGRect(x: 0, y: 0, width: (keyWindow?.frame.width)!, height: (keyWindow?.frame.height)!)
                
                let width = transView.frame.width
                let height = transView.frame.height
                levelUp.frame = CGRect(x: width/2 - 150, y: height/2 - 150, width: 300, height: 300)
                levelUp.setImage(UIImage(named: "LevelUp"), for: .normal)
                
                levelUp.addTarget(self, action: #selector(self.leveledUp), for: .touchUpInside)
                
                keyWindow?.addSubview(transView)
                keyWindow?.addSubview(levelUp)
                
                GIDSignedInUser.userLevel += 1
                saveUserLevel(level: GIDSignedInUser.userLevel)
            }
        } else {
            chooseVideoButton.isEnabled = true
            submitButton.isEnabled = true
            deleteChallengeButton.isEnabled = true
        }
    }
    
    @objc func leveledUp(_ sender: UIButton) {
        
        sender.removeFromSuperview()
        transView.removeFromSuperview()
    }
    
    @IBAction func submitVideo(_ sender: Any) {
        showSubmitAlert()
    }
    
    @IBAction func unwindToMyTask(_ sender: UIStoryboardSegue) {
        if let source = sender.source as? MyVideoViewController {
            
            videoUrl = "http://www.youtube.com/embed/\(source.selectedVideoId!)"
            loadChallenge()
        }
    }
    
    func saveUserLevel(level: Int) {
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let databaseRef = Database.database().reference().child("users/level/\(uid)")
        
        let saveLevel = [
            "level": level
        ] as [String: Any]
        
        databaseRef.setValue(saveLevel)
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
        
        self.viewCount = viewCount
        self.viewTarget = viewTarget
        self.likeCount = likeCount
        self.likeTarget = likeTarget
        self.commentCount = commentCount
        self.commentTarget = commentTarget
        checkTick(type: 1)
        
        databaseRef.setValue(saveChallenge) { (error, ref) in
            completion(error == nil)
        }
    }
    
    @IBAction func deleteChallengeData(_ sender: Any) {
        
        showDeleteAlert()
    }
    
    func submitTheVideo() {
        guard
            let index = myChallenge?.index,
            let challengeTitle = myChallenge?.myChallengeTitle,
            let videoLink = self.videoUrl,
            let viewCount = Int((videoDetail?.items![0].statistics?.viewCount)!),
            let viewTarget = myChallenge?.myChallengeTask.viewTarget,
            let likeCount = Int((videoDetail?.items![0].statistics?.likeCount)!),
            let likeTarget = myChallenge?.myChallengeTask.likeTarget,
            let commentCount = Int((videoDetail?.items![0].statistics?.commentCount)!),
            let commentTarget = myChallenge?.myChallengeTask.commentTarget
        else {
                return
        }
        
        saveChallengeData(index: index, title: challengeTitle, videoLink: videoLink, viewCount: viewCount, viewTarget: viewTarget, likeCount: likeCount, likeTarget: likeTarget, commentCount: commentCount, commentTarget: commentTarget) { (success) in
            if success {
                print("Berhasil")
            } else {
                print("Error")
            }
        }
    }
    
    func deleteTheChallengeData() {
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let databaseRef = Database.database().reference().child("users/challengeJoined/\(uid)/\((self.challengeTitle)!)")
        
        databaseRef.removeValue { (error, _) in
            print(error)
            self.performSegue(withIdentifier: "MyTaskToHome", sender: self)
        }
    }
    
    func showSubmitAlert() {
        
        let alert = UIAlertController(title: "Anda yakin memilih video \"\((self.videoNameLabel.text)!)\"", message: "Setelah menekan Pilih, anda telah setuju memilih video tersebut.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Pilih", style: .default, handler: { (action) in
            self.submitTheVideo()
        }))
        alert.addAction(UIAlertAction(title: "Batal", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showDeleteAlert() {
        
        let alert = UIAlertController(title: "Anda yakin ingin menghapus challenge \"\((self.challengeTitle)!)\"", message: "Setelah menekan Hapus, anda telah setuju memilih video tersebut.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Hapus", style: .default, handler: { (action) in
            self.deleteTheChallengeData()
        }))
        alert.addAction(UIAlertAction(title: "Batal", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension String {
    var youtubeID: String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: count)
        
        guard let result = regex?.firstMatch(in: self, options: [], range: range) else {
            return nil
        }
        
        return (self as NSString).substring(with: result.range)
    }
}
