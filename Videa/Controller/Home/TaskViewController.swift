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

    @IBOutlet weak var challengeTitleLabel: UITextView!
    @IBOutlet weak var videoWebView: UIWebView!
    @IBOutlet weak var viewLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var videoNameLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    var videoDetail: VideoDetail?
    var myChallenge: MyChallenge?
    var apiKey = "AIzaSyA614LZH2YQaHu3_hyXnEkOq2d9p0Bd0x8"
    
    var challengeTitle: String?
    var viewTarget: Int?
    var likeTarget: Int?
    var commentTarget: Int?
    var videoUrl: String?
    
    @IBAction func chooseVideo(_ sender: Any) {
        performSegue(withIdentifier: "TaskToMyVideo", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        challengeTitle = myChallenge?.myChallengeTitle
        viewTarget = myChallenge?.myChallengeTask.viewTarget
        likeTarget = myChallenge?.myChallengeTask.likeTarget
        commentTarget = myChallenge?.myChallengeTask.commentTarget
        videoUrl = myChallenge?.myChallengeUrl
        
        challengeTitleLabel.text = challengeTitle
        viewLabel.text = "Dapat \(viewTarget!) Views"
        likeLabel.text = "Dapat \(likeTarget!) Likes"
        commentLabel.text = "Dapat \(commentTarget!) Comments"
        
        if videoUrl != "" {
            loadChallenge()
        } else {
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
                self.submitButton.isEnabled = true
            }
        }
        getVideoTask.resume()
    }
    
    @IBAction func submitVideo(_ sender: Any) {
        
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
    
    @IBAction func unwindToMyTask(_ sender: UIStoryboardSegue) {
        if let source = sender.source as? MyVideoViewController {
            
            videoUrl = "http://www.youtube.com/embed/\(source.selectedVideoId!)"
            loadChallenge()
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
