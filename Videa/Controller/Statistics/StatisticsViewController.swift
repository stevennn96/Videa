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
    @IBOutlet weak var connectUIButton: UIButton!
    
    var apiKey: String = ""
    var username: String = ""
    var channelTitle: String = ""
    var totalSubscribers: String = ""
    var totalViews: String = ""
    
    var getChannelTask: URLSessionDataTask?
    var urlData: Data?
    var reloadCounter: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        connectUIButton.layer.cornerRadius = 5
        reloadCounter = 0
        apiKey = "AIzaSyA614LZH2YQaHu3_hyXnEkOq2d9p0Bd0x8"
    }
    
    @IBAction func connectButton(_ sender: Any) {
        
        username = usernameTextField.text!
        let channelUrl = URL(string: "https://www.googleapis.com/youtube/v3/channels?key=\(apiKey)&forUsername=\(username)&part=snippet,contentDetails,statistics")
        
        var channelDetail: ChannelDetail?
        
        getChannelTask = URLSession.shared.dataTask(with: channelUrl!) { (data, response, error) in
            do {
                channelDetail = try JSONDecoder().decode(ChannelDetail.self, from: data!)
                self.urlData = data
            } catch let error as NSError {
                print(error)
            }
            
            if channelDetail != nil {
                print(channelDetail!.items.count)
                
                if channelDetail!.items.count != 0 {
                    self.channelTitle = channelDetail!.items[0].snippet.title
                    self.totalSubscribers = channelDetail!.items[0].statistics.subscriberCount
                    self.totalViews = channelDetail!.items[0].statistics.viewCount
                }
                else {
                    print("Channel detail empty")
                }
            }
            else {
                print("No channel detail found")
            }
        }
        
        getChannelTask?.resume()
        
        if self.channelTitle == "" {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                self.reloadCounter += 1
                if(self.reloadCounter > 10){
                    print("Reloaded 10 times but no result")
                    self.reloadCounter = 0
                }
                else{
                    self.connectUIButton.sendActions(for: .touchUpInside)
                }
            }
        }
        
//        print(apiKey)
//        print(username)
//        print(self.channelTitle)
//        print(self.totalSubscribers)
//        print(self.totalViews)
        
        if self.channelTitle != "" {
            print(apiKey)
            print(username)
            print(self.channelTitle)
            print(self.totalSubscribers)
            print(self.totalViews)
            performSegue(withIdentifier: "StatisticsToStatisticsData", sender: nil)
        }
        else {
            print("Cannot pass")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? StatisticsDataViewController {
            destination.channelTitle = self.channelTitle
            destination.totalSubscribers = self.totalSubscribers
        }
    }

}