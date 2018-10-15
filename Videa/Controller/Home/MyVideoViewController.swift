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
    var selectedVideoId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadVideo(order: "date")
        
        myVideoTableView.delegate = self
        myVideoTableView.dataSource = self
    }
    
    
    @IBAction func setOrder(_ sender: UIButton) {
        var order: String?
        
        if sender.tag == 10 {
            order = "view"
            loadVideo(order: order!)
            orderLabel.text = "Terbanyak Ditonton"
        } else if sender.tag == 20 {
            order = "date"
            loadVideo(order: order!)
            orderLabel.text = "Paling Baru"
        }
        
        sortView.isHidden = true
    }
    
    @IBAction func chooseOrder(_ sender: Any) {
        sortView.isHidden = false
    }
    
    func loadVideo(order: String){
        
        myVideo.removeAll()
        
        var searchBy: SearchDetail?
        if order == "date" {
            searchBy = GIDSignedInUser.searchByDate
        } else if order == "view" {
            searchBy = GIDSignedInUser.searchByView
        }
        
        for i in (searchBy?.items)! {
            let videoId = i.id?.videoId
            print(videoId)
            var videoImageUrl: String?
            var videoTitle: String?
            var videoView: String?
            var videoComment: String?
            var videoLike: String?
            var videoDislike: String?
            
            var videoDetail: VideoDetail?
            var newMyVideo: MyVideo!
            
            let url = URL(string: "https://www.googleapis.com/youtube/v3/videos?key=AIzaSyCSSeFz17e2vePbWpS0_KWN7wHxWhCQoRU&id=\(videoId!)&part=snippet,contentDetails,statistics")
            
            let getVideoTask = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                do {
                    videoDetail = try JSONDecoder().decode(VideoDetail.self, from: data!)
                } catch let error as NSError {
                    print(error)
                }
                
                
                videoTitle = videoDetail?.items![0].snippet?.title
                videoImageUrl = videoDetail?.items![0].snippet?.thumbnails?.default?.url
                videoView = videoDetail?.items![0].statistics?.viewCount
                videoComment = videoDetail?.items![0].statistics?.commentCount
                videoLike = videoDetail?.items![0].statistics?.likeCount
                videoDislike = videoDetail?.items![0].statistics?.dislikeCount
                
                newMyVideo = MyVideo(imageUrl: videoImageUrl!, title: videoTitle!, viewCount: videoView!, commentCount: videoComment!, likeCount: videoLike!, dislikeCount: videoDislike!)
                
                print(newMyVideo.title)
                self.myVideo.append(newMyVideo)
                print("Video Detail Retrieved")
                
                DispatchQueue.main.async {
                    
                    self.myVideoTableView.reloadData()
                }
            }
            
            getVideoTask.resume()
            while videoDetail == nil {
                continue
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
