//
//  StatisticsDataViewController.swift
//  Videa
//
//  Created by Kensen Tjoa on 23/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit

class StatisticsDataViewController: UIViewController {

    @IBOutlet weak var channelTitleLabel: UILabel!
    @IBOutlet weak var totalSubscribersLabel: UILabel!
    @IBOutlet weak var totalViewsLabel: UILabel!
    
    var channelTitle: String = ""
    var totalSubscribers: String = ""
    var totalViews: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        channelTitleLabel.text = channelTitle
        totalSubscribersLabel.text = "\(totalSubscribers) Subscribers"
        totalViewsLabel.text = "\(totalViews) Views"
        // Do any additional setup after loading the view.
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
