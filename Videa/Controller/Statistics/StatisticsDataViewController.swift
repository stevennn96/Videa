//
//  StatisticsDataViewController.swift
//  Videa
//
//  Created by Kensen Tjoa on 23/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImage.layer.cornerRadius = userImage.frame.size.width/2
        userImage.layer.cornerRadius = userImage.frame.size.height/2
        userImage.clipsToBounds = true
        
        accountView.layer.shadowColor = UIColor.black.cgColor
        accountView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        accountView.layer.shadowOpacity = 0.6
        accountView.layer.shadowRadius = 0.8
        
        print("CH: \(channelTitle)")
        print("CH: \(totalSubscribers)")
        channelTitleLabel.text = channelTitle
        
        let subsInt: Int = Int(totalSubscribers)!
        let fmt = NumberFormatter()
        fmt.numberStyle = .decimal
        fmt.locale = NSLocale(localeIdentifier: "id_ID") as Locale!
        totalSubscribers = fmt.string(for: subsInt)!
        totalSubscribersLabel.text = "\(totalSubscribers)"
        
        statisticsData.append(StatisticsData(date: "29/08/2018", totalSubscribers: "+39", totalViews: "+3.427"))
        statisticsData.append(StatisticsData(date: "28/08/2018", totalSubscribers: "+66", totalViews: "+4.265"))
        statisticsData.append(StatisticsData(date: "27/08/2018", totalSubscribers: "+59", totalViews: "+4.022"))
        statisticsData.append(StatisticsData(date: "26/08/2018", totalSubscribers: "+96", totalViews: "+5.758"))
        statisticsData.append(StatisticsData(date: "25/08/2018", totalSubscribers: "+63", totalViews: "+5.327"))
        statisticsData.append(StatisticsData(date: "24/08/2018", totalSubscribers: "+93", totalViews: "+4.902"))
        statisticsData.append(StatisticsData(date: "23/08/2018", totalSubscribers: "+91", totalViews: "+4.831"))
        
        statisticsDataTableView.reloadData()
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
