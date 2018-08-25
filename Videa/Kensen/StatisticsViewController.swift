//
//  StatisticsViewController.swift
//  Videa
//
//  Created by Kensen Tjoa on 23/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statisticsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = statisticsData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatisticsDataCell") as! StatisticsDataTableViewCell
        
        cell.setStatisticsData(statisticsData: data)
        return cell
    }
    

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var connectUIButton: UIButton!
    
    var apiKey: String = ""
    var username: String = ""
    var channelTitle: String = ""
    var totalSubscribers: String = ""
    var totalViews: String = ""
    var statisticsData: [StatisticsData] = []
    
    var getChannelTask: URLSessionDataTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiKey = "AIzaSyA614LZH2YQaHu3_hyXnEkOq2d9p0Bd0x8"
    }
    
    @IBAction func connectButton(_ sender: Any) {
        
        username = usernameTextField.text!
        let channelUrl = URL(string: "https://www.googleapis.com/youtube/v3/channels?key=\(apiKey)&forUsername=\(username)&part=snippet,contentDetails,statistics")
        
        var channelDetail: ChannelDetail?
        
        getChannelTask = URLSession.shared.dataTask(with: channelUrl!) { (data, response, error) in
            do {
                channelDetail = try JSONDecoder().decode(ChannelDetail.self, from: data!)
            } catch let error as NSError {
                print(error)
            }
            
            self.channelTitle = channelDetail!.items[0].snippet.title
            self.totalSubscribers = channelDetail!.items[0].statistics.subscriberCount
            self.totalViews = channelDetail!.items[0].statistics.viewCount
        }
        
        getChannelTask?.resume()
        
        if self.channelTitle == "" {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                self.connectUIButton.sendActions(for: .touchUpInside)
            }
        }
        
        print(apiKey)
        print(username)
        print(self.channelTitle)
        print(self.totalSubscribers)
        print(self.totalViews)
        
        if self.channelTitle != "" {
            performSegue(withIdentifier: "StatisticsToStatisticsData", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? StatisticsDataViewController {
            destination.channelTitle = self.channelTitle
            destination.totalSubscribers = self.totalSubscribers
            destination.totalViews = self.totalViews
        }
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
