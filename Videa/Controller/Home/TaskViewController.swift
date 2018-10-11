//
//  TaskViewController.swift
//  Videa
//
//  Created by Kensen Tjoa on 10/10/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit
import WebKit

class TaskViewController: UIViewController {

    @IBOutlet weak var videoWebView: UIWebView!
    @IBOutlet weak var viewLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var videoNameLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    var myChallenge: MyChallenge?
    var apiKey = "AIzaSyA614LZH2YQaHu3_hyXnEkOq2d9p0Bd0x8"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard
            let viewTarget = myChallenge?.myChallengeTask.viewTarget,
            let likeTarget = myChallenge?.myChallengeTask.likeTarget,
            let commentTarget = myChallenge?.myChallengeTask.commentTarget,
            let videoUrl = myChallenge?.myChallengeUrl
        else{
            return
        }
        
        viewLabel.text = "Dapat \(viewTarget) Views"
        likeLabel.text = "Dapat \(likeTarget) Likes"
        commentLabel.text = "Dapat \(commentTarget) Comments"
        
        let link = "http://www.youtube.com/embed/Lvqc1BQW55g"
        let url = URL(string: link)
        videoWebView.loadRequest(URLRequest(url: url!))
        
        var videoDetail: VideoDetail?
        let apiUrl = URL(string: "https://www.googleapis.com/youtube/v3/videos?key=\(apiKey)&id=\(link.youtubeID!)&part=snippet,contentDetails,statistics")
        
        let getVideoTask = URLSession.shared.dataTask(with: apiUrl!) { (data, response, error) in
            do {
                videoDetail = try JSONDecoder().decode(VideoDetail.self, from: data!)
            } catch let error as NSError {
                print(error)
            }
            
            DispatchQueue.main.async {
                self.videoNameLabel.text = videoDetail?.items![0].snippet?.title
            }
        }
        
        // Do any additional setup after loading the view.
        
        getVideoTask.resume()
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
