//
//  StatisticsDataTableViewCell.swift
//  Videa
//
//  Created by Kensen Tjoa on 24/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit

class StatisticsDataTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var totalSubscribersLabel: UILabel!
    @IBOutlet weak var totalViewsLabel: UILabel!
    
    func setStatisticsData(statisticsData: StatisticsData) {
        dateLabel.text = statisticsData.date
        totalSubscribersLabel.text = statisticsData.totalSubscribers
        totalViewsLabel.text = statisticsData.totalViews
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dataView.layer.shadowColor = UIColor.black.cgColor
        dataView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        dataView.layer.shadowOpacity = 0.6
        dataView.layer.shadowRadius = 0.8
        
//        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: self.frame.width - 10, height: self.frame.height - 10))
//        let image = UIImage(named: "rectangleShadow")
//        imageView.image = image
//        self.backgroundView = UIView()
//        self.backgroundView!.addSubview(imageView)
//
//        let screenSize = UIScreen.main.bounds
//        let separatorHeight = CGFloat(7.0)
//        let additionalSeparator = UIView.init(frame: CGRect(x: 0, y: self.frame.size.height-separatorHeight, width: screenSize.width, height: separatorHeight))
//        additionalSeparator.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
//        self.addSubview(additionalSeparator)
    }
}
