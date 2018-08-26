//
//  StatisticsDataViewController.swift
//  Videa
//
//  Created by Kensen Tjoa on 23/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit

class StatisticsDataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var statisticsDataTableView: UITableView!
    @IBOutlet weak var channelTitleLabel: UILabel!
    @IBOutlet weak var totalSubscribersLabel: UILabel!
    @IBOutlet weak var totalViewsLabel: UILabel!
    
    var statisticsData: [StatisticsData] = []
    
    var channelTitle: String = ""
    var totalSubscribers: String = ""
    var totalViews: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        channelTitleLabel.text = channelTitle
        totalSubscribersLabel.text = "\(totalSubscribers) Subscribers"
        totalViewsLabel.text = "\(totalViews) Views"
        
        statisticsData.append(StatisticsData(date: "20/08/2018", totalSubscribers: "2000", totalViews: "30000"))
        statisticsData.append(StatisticsData(date: "21/08/2018", totalSubscribers: "2100", totalViews: "35000"))
        
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
