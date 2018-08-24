//
//  StatisticsData.swift
//  Videa
//
//  Created by Kensen Tjoa on 24/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import Foundation

class StatisticsData {
    
    var date: String
    var totalSubscribers: Int
    var totalViews: Int
    
    init(date: String, totalSubscribers: Int, totalViews: Int) {
        self.date = date
        self.totalSubscribers = totalSubscribers
        self.totalViews = totalViews
    }
}
