//
//  StatisticsDataTableViewCell.swift
//  Videa
//
//  Created by Kensen Tjoa on 24/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit

class StatisticsDataTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var totalSubscribersLabel: UILabel!
    @IBOutlet weak var totalViewsLabel: UILabel!
    
    func setStatisticsData(statisticsData: StatisticsData) {
        dateLabel.text = statisticsData.date
        totalSubscribersLabel.text = statisticsData.totalSubscribers
        totalViewsLabel.text = statisticsData.totalViews
    }
}
