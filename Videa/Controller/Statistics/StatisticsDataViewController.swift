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
    
    var channelTitle: String = ""
    var totalSubscribers: String = ""
    var totalViews: String = ""
    var userImageUrl: String = ""
    
    var columnHeader = [ColumnHeader]()
    var row = [Row]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var channelDetail: ChannelDetail?
        
        channelTitle = (GIDSignedInUser.channelDetail?.items![0].snippet?.title)!
        totalSubscribers = (GIDSignedInUser.channelDetail?.items![0].statistics?.subscriberCount)!
        userImageUrl = (GIDSignedInUser.channelDetail?.items![0].snippet?.thumbnails?.default?.url)!
        
        let subsInt: Int = Int(self.totalSubscribers)!
        let fmt = NumberFormatter()
        fmt.numberStyle = .decimal
        fmt.locale = NSLocale(localeIdentifier: "id_ID") as Locale!
        
        var startDate: String?
        var endDate: String?
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        endDate = formatter.string(from: Date())
        print(endDate)
        
        var dayToAdd = DateComponents()
        dayToAdd.day = -29
        let date = Calendar.current.date(byAdding: dayToAdd, to: Date())!
        startDate = formatter.string(from: date)
        print(startDate)
        
        var statistics: Analytics?
        
        let url = URL(string: "https://youtubeanalytics.googleapis.com/v2/reports?dimensions=day&endDate=\(endDate!)&ids=channel==MINE&metrics=views,subscribersGained,subscribersLost&startDate=\(startDate!)&access_token=\(GIDSignedInUser.accessToken)")
        
        let getStatistics = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                statistics = try JSONDecoder().decode(Analytics.self, from: data!)
            } catch let error as NSError {
                print(error)
            }
            
            if statistics != nil {
                print("Statistics Retrieved")
                
                self.columnHeader = (statistics?.columnHeaders)!
                self.row = (statistics?.rows)!
                self.row.reverse()
                for i in self.columnHeader {
                    print(i.name)
                }
                
                for i in self.row {
                    let subscriberChange = i.subscribersGained! - i.subscribersLost!
                    var subscriberString: String?
                    
                    if subscriberChange == 0 {
                        subscriberString = "\(subscriberChange)"
                    } else if subscriberChange < 0 {
                        subscriberString = "\(subscriberChange)"
                    } else {
                        subscriberString = "+\(subscriberChange)"
                    }
                    
                    self.statisticsData.append(StatisticsData(date: i.date!, totalSubscribers: "\(subscriberString!)", totalViews: "+\(i.views!)"))
                }
            }
        }
        
        getStatistics.resume()
        
        while statistics == nil {
            continue
        }
        
        
        
        
        
//        totalSubscribers = fmt.string(for: subsInt)!
//
//                            self.statisticsData.append(StatisticsData(date: "29/08/2018", totalSubscribers: "+39", totalViews: "+3.427"))
//                            self.statisticsData.append(StatisticsData(date: "28/08/2018", totalSubscribers: "+66", totalViews: "+4.265"))
//                            self.statisticsData.append(StatisticsData(date: "27/08/2018", totalSubscribers: "+59", totalViews: "+4.022"))
//                            self.statisticsData.append(StatisticsData(date: "26/08/2018", totalSubscribers: "+96", totalViews: "+5.758"))
//                            self.statisticsData.append(StatisticsData(date: "25/08/2018", totalSubscribers: "+63", totalViews: "+5.327"))
//                            self.statisticsData.append(StatisticsData(date: "24/08/2018", totalSubscribers: "+93", totalViews: "+4.902"))
//                            self.statisticsData.append(StatisticsData(date: "23/08/2018", totalSubscribers: "+91", totalViews: "+4.831"))
        
        DispatchQueue.main.async {
            self.channelTitleLabel.text = self.channelTitle
            self.totalSubscribersLabel.text = self.totalSubscribers
            self.userImage.downloaded(from: self.userImageUrl)
            self.statisticsDataTableView.reloadData()
        }
        
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
