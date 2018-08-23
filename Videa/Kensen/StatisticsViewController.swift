//
//  StatisticsViewController.swift
//  Videa
//
//  Created by Kensen Tjoa on 23/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    var apiKey: String = ""
    var username: String = ""
    var channelTitle: String = ""
    var totalSubscribers: String = ""
    var totalViews: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiKey = "AIzaSyAkEWVahXSgJmB4PrgMrF_fSq1I6P4B0yQ"
        
    }
    
    @IBAction func connectButton(_ sender: Any) {
        username = usernameTextField.text!
//        username = ""
        let channelUrl = URL(string: "https://www.googleapis.com/youtube/v3/channels?key=\(apiKey)&forUsername=\(username)&part=snippet,contentDetails,statistics")
        
        var channelDetail: ChannelDetail?
        
        let getChannelTask = URLSession.shared.dataTask(with: channelUrl!) { (data, response, error) in
            do {
                channelDetail = try JSONDecoder().decode(ChannelDetail.self, from: data!)
            } catch let error as NSError {
                print(error)
            }
            
            self.channelTitle = channelDetail!.items[0].snippet.title
            self.totalSubscribers = channelDetail!.items[0].statistics.subscriberCount
            self.totalViews = channelDetail!.items[0].statistics.viewCount
        }
        
        print(apiKey)
        print(username)
        print(self.channelTitle)
        print(self.totalSubscribers)
        print(self.totalViews)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? StatisticsDataViewController {
            
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
