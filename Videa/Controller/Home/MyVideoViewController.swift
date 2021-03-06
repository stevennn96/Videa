//
//  MyVideoViewController.swift
//  Videa
//
//  Created by Kensen Tjoa on 13/10/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit

class MyVideoViewController: UIViewController {

    @IBOutlet weak var myVideoTableView: UITableView!
    @IBOutlet weak var sortView: UIView!
    @IBOutlet weak var orderLabel: UILabel!
    
    var myVideo = [MyVideo]()
    var tmpVideos = [MyVideo]()
    var videoIds = [String]()
    var videoDetail: VideoDetail?
    var selectedVideoId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadVideo(order: "date") { (success) in
            if success {
//                self.myVideoTableView.reloadData()
            }
        }
        
        myVideoTableView.delegate = self
        myVideoTableView.dataSource = self
    }
    
    
    @IBAction func setOrder(_ sender: UIButton) {
        var order: String?
        
        if sender.tag == 10 {
            order = "view"
            loadVideo(order: "view") { (success) in
                if success {
//                    self.myVideoTableView.reloadData()
                }
            }
            orderLabel.text = "Terbanyak Ditonton"
        } else if sender.tag == 20 {
            order = "date"
            loadVideo(order: "date") { (success) in
                if success {
//                    self.myVideoTableView.reloadData()
                }
            }
            orderLabel.text = "Paling Baru"
        }
        
        sortView.isHidden = true
    }
    
    @IBAction func chooseOrder(_ sender: Any) {
        sortView.isHidden = false
    }
    
    func loadVideo(order: String, onComplete: @escaping (Bool) -> ()){
        
        myVideo.removeAll()
        
        var searchBy: SearchDetail?
        if order == "date" {
            searchBy = GIDSignedInUser.searchByDate
        } else if order == "view" {
            searchBy = GIDSignedInUser.searchByView
        }
        
        
        for i in (searchBy?.items)! {
            let videoId = i.id?.videoId
            videoIds.append(videoId!)
            print(videoId)
            var vId: String?
            var videoImageUrl: String?
            var videoTitle: String?
            var videoView: String?
            var videoComment: String?
            var videoLike: String?
            var videoDislike: String?
            
            var newMyVideo: MyVideo!
            
            let url = URL(string: "https://www.googleapis.com/youtube/v3/videos?key=AIzaSyCSSeFz17e2vePbWpS0_KWN7wHxWhCQoRU&id=\(videoId!)&part=snippet,contentDetails,statistics")
            
            let getVideoTask = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                do {
                    self.videoDetail = try JSONDecoder().decode(VideoDetail.self, from: data!)
                } catch let error as NSError {
                    print(error)
                }
                
                vId = self.videoDetail?.items![0].id
                videoTitle = self.videoDetail?.items![0].snippet?.title
                videoImageUrl = self.videoDetail?.items![0].snippet?.thumbnails?.default?.url
                videoView = self.videoDetail?.items![0].statistics?.viewCount
                videoComment = self.videoDetail?.items![0].statistics?.commentCount
                videoLike = self.videoDetail?.items![0].statistics?.likeCount
                videoDislike = self.videoDetail?.items![0].statistics?.dislikeCount
                
                newMyVideo = MyVideo(id: vId!, imageUrl: videoImageUrl!, title: videoTitle!, viewCount: videoView!, commentCount: videoComment!, likeCount: videoLike!, dislikeCount: videoDislike!)
                
                self.tmpVideos.append(newMyVideo)
                print("Video Detail Retrieved ")
                if self.tmpVideos.count == self.videoIds.count{
                    for id in self.videoIds{
                        for vid in self.tmpVideos{
                            if vid.videoId == id {
                                self.myVideo.append(vid)
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.myVideoTableView.reloadData()
                    }
                }
                
                DispatchQueue.main.async {
                    
                    print("YO")
                    self.applyLoadingScreen()
//                    self.myVideoTableView.reloadData()
                }
            }
            
            getVideoTask.resume()
            while videoDetail == nil {
                continue
            }
        }
        
        onComplete(true)
    }
    
    func applyLoadingScreen() {
        
        let loadingImageView = UIImageView()
        let keyWindow = UIApplication.shared.keyWindow
        
        DispatchQueue.main.async {
            
            loadingImageView.frame = CGRect(x: 0, y: 0, width: (keyWindow?.frame.width)!, height: (keyWindow?.frame.height)!)
            loadingImageView.image = UIImage(named: "LoadingScreen")
            
            keyWindow?.addSubview(loadingImageView)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                while self.videoDetail == nil {
                    continue
                }
                
                loadingImageView.removeFromSuperview()
            }
        }
    }
}

extension MyVideoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myVideo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myVideoTableView.dequeueReusableCell(withIdentifier: "reuseVideo") as? MyVideoTableViewCell
        
        cell?.setMyVideo(myVideo: myVideo[indexPath.row])
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedVideoId = (GIDSignedInUser.searchByDate?.items![indexPath.row].id?.videoId)!
        performSegue(withIdentifier: "MyVideoToMyTask", sender: self)
    }
}
