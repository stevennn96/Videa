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
    
    var loaded = false
    
    var channelTitle: String = ""
    var totalSubscribers: String = ""
    var totalViews: String = ""
    var userImageUrl: String = ""
    
    var statistics: Analytics?
    var columnHeader = [ColumnHeader]()
    var row = [Row]()
    
    let fmt = NumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var channelDetail: ChannelDetail?
        
        channelTitle = (GIDSignedInUser.channelDetail?.items![0].snippet?.title)!
        totalSubscribers = (GIDSignedInUser.channelDetail?.items![0].statistics?.subscriberCount)!
        userImageUrl = (GIDSignedInUser.channelDetail?.items![0].snippet?.thumbnails?.default?.url)!
        
        let subsInt: Int = Int(self.totalSubscribers)!
        
        fmt.numberStyle = .decimal
        fmt.locale = NSLocale(localeIdentifier: "id_ID") as Locale!
        totalSubscribers = fmt.string(for: subsInt)!
        
//        while statistics == nil {
//            continue
//        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        if loaded == false {
        
            applyLoadingScreen()
            getStatisticsData()
            
            loaded = true
        }
    }
    
    func applyLoadingScreen() {
        
        let loadingImageView = UIImageView()
        let keyWindow = UIApplication.shared.keyWindow

        loadingImageView.frame = CGRect(x: 0, y: 0, width: (keyWindow?.frame.width)!, height: (keyWindow?.frame.height)!)
        loadingImageView.image = UIImage(named: "LoadingScreen")
        
        keyWindow?.addSubview(loadingImageView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            while self.statistics == nil {
                continue
            }
            
            print(self.statisticsData.count)
            self.channelTitleLabel.text = self.channelTitle
            self.totalSubscribersLabel.text = self.totalSubscribers
            self.userImage.downloaded(from: self.userImageUrl)
            self.userImage.layer.borderWidth = 1
            self.userImage.layer.masksToBounds = false
            self.userImage.layer.cornerRadius = self.userImage.frame.height/2
            self.userImage.clipsToBounds = true
            self.statisticsDataTableView.reloadData()
            loadingImageView.removeFromSuperview()
        }
    }
    
    func getStatisticsData() {
        
        var startDate: String?
        var endDate: String?
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        endDate = formatter.string(from: Date())
        
        var dayToAdd = DateComponents()
        dayToAdd.day = -29
        let date = Calendar.current.date(byAdding: dayToAdd, to: Date())!
        startDate = formatter.string(from: date)
        
        let url = URL(string: "https://youtubeanalytics.googleapis.com/v2/reports?dimensions=day&endDate=\(endDate!)&ids=channel==MINE&metrics=views,subscribersGained,subscribersLost&startDate=\(startDate!)&access_token=\(GIDSignedInUser.accessToken)")
        
        let getStatistics = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                self.statistics = try JSONDecoder().decode(Analytics.self, from: data!)
            } catch let error as NSError {
                print(error)
            }
            
            if self.statistics != nil {
                print("Statistics Retrieved")
                
                self.columnHeader = (self.statistics?.columnHeaders)!
                self.row = (self.statistics?.rows)!
                self.row.reverse()
                
                for i in self.row {
                    let subscriberChange = i.subscribersGained! - i.subscribersLost!
                    var subscriberString: String?
                    
                    if subscriberChange == 0 {
                        subscriberString = "\(self.fmt.string(for: subscriberChange)!)"
                    } else if subscriberChange < 0 {
                        subscriberString = "\(self.fmt.string(for: subscriberChange)!)"
                    } else {
                        subscriberString = "+\(self.fmt.string(for: subscriberChange)!)"
                    }
                    
                    let iDate = i.date!
                    let iDateFormatter = DateFormatter()
                    iDateFormatter.dateFormat = "yyyy-MM-dd"
                    let date = iDateFormatter.date(from: iDate)
                    
                    let newDateFormatter = DateFormatter()
                    newDateFormatter.dateFormat = "EEEE, dd LLLL yyyy"
                    
                    let newDate = newDateFormatter.string(from: date!)
                    
                    self.statisticsData.append(StatisticsData(date: newDate, totalSubscribers: "\(subscriberString!)", totalViews: "+\(self.fmt.string(for: i.views!)!)"))
                }
            }
        }
        
        getStatistics.resume()
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
