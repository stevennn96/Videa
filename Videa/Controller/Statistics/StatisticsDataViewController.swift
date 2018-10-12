//
//  StatisticsDataViewController.swift
//  Videa
//
//  Created by Kensen Tjoa on 23/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit
import GoogleSignIn
import FirebaseAuth
import Firebase

class StatisticsDataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var accountView: UIView!
    @IBOutlet weak var statisticsDataTableView: UITableView!
    @IBOutlet weak var channelTitleLabel: UILabel!
    @IBOutlet weak var totalSubscribersLabel: UILabel!
    
    var statisticsData: [StatisticsData] = []
    
    var apiKey: String = "AIzaSyA614LZH2YQaHu3_hyXnEkOq2d9p0Bd0x8"
    var accessToken: String = ""
    var channelTitle: String = ""
    var totalSubscribers: String = ""
    var totalViews: String = ""
    var userImageUrl: String = ""
    
    var getChannelTask: URLSessionDataTask?
    var urlData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser != nil {
            print("in")
            // User is signed in.
            // ...
        } else {
            print("out")
            // No user is signed in.
            // ...
        }
        
        if GIDSignIn.sharedInstance()?.currentUser != nil {
            print("GIDin")
            accessToken = (GIDSignIn.sharedInstance()?.currentUser.authentication.accessToken)!
            print(accessToken)
        } else {
            print("GIDout")
        }
        
        let url = URL(string: "https://www.googleapis.com/youtube/v3/channels?part=snippet,contentDetails,statistics&mine=true&access_token=\(accessToken)")
        
        var channelDetail: ChannelDetail?
        
        getChannelTask = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                channelDetail = try JSONDecoder().decode(ChannelDetail.self, from: data!)
                self.urlData = data
            } catch let error as NSError {
                print(error)
            }
            
            if channelDetail != nil {
                print(channelDetail!.items?.count)
                
                if channelDetail!.items?.count != 0 {
                    self.channelTitle = (channelDetail!.items![0].snippet?.title)!
                    self.totalSubscribers = (channelDetail!.items![0].statistics?.subscriberCount)!
                    self.totalViews = (channelDetail!.items![0].statistics?.viewCount)!
                    self.userImageUrl = (channelDetail!.items![0].snippet?.thumbnails?.default?.url)!
                    
//                    self.userImage.layer.cornerRadius = self.userImage.frame.size.width/2
//                    self.userImage.layer.cornerRadius = self.userImage.frame.size.height/2
//                    self.userImage.clipsToBounds = true
//
//                    self.accountView.layer.shadowColor = UIColor.black.cgColor
//                    self.accountView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
//                    self.accountView.layer.shadowOpacity = 0.6
//                    self.accountView.layer.shadowRadius = 0.8
                    
                    print("CH: \(self.channelTitle)")
                    print("CH: \(self.totalSubscribers)")
                    DispatchQueue.main.async {
                        self.channelTitleLabel.text = self.channelTitle
                        self.userImage.downloaded(from: self.userImageUrl)
                    }
                    
                    let subsInt: Int = Int(self.totalSubscribers)!
                    let fmt = NumberFormatter()
                    fmt.numberStyle = .decimal
                    fmt.locale = NSLocale(localeIdentifier: "id_ID") as Locale!
                    DispatchQueue.main.async {
                        self.totalSubscribers = fmt.string(for: subsInt)!
                    self.totalSubscribersLabel.text = "\(self.totalSubscribers)"
                    }
                    
                    self.statisticsData.append(StatisticsData(date: "29/08/2018", totalSubscribers: "+39", totalViews: "+3.427"))
                    self.statisticsData.append(StatisticsData(date: "28/08/2018", totalSubscribers: "+66", totalViews: "+4.265"))
                    self.statisticsData.append(StatisticsData(date: "27/08/2018", totalSubscribers: "+59", totalViews: "+4.022"))
                    self.statisticsData.append(StatisticsData(date: "26/08/2018", totalSubscribers: "+96", totalViews: "+5.758"))
                    self.statisticsData.append(StatisticsData(date: "25/08/2018", totalSubscribers: "+63", totalViews: "+5.327"))
                    self.statisticsData.append(StatisticsData(date: "24/08/2018", totalSubscribers: "+93", totalViews: "+4.902"))
                    self.statisticsData.append(StatisticsData(date: "23/08/2018", totalSubscribers: "+91", totalViews: "+4.831"))
                    
                    DispatchQueue.main.async {
                        self.statisticsDataTableView.reloadData()
                    }
                }
                else {
                    print("Channel detail empty")
                }
            }
            else {
                print("No channel detail found")
            }
        }
        
        getChannelTask?.resume()
        
        
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statisticsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = statisticsData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatisticsDataCell") as! StatisticsDataTableViewCell
        
        cell.setStatisticsData(statisticsData: data)
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
