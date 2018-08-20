//
//  IntroductionViewController.swift
//  Videa
//
//  Created by Steven - on 15/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit

class IntroductionViewController: UIViewController {

    @IBOutlet weak var embedYoutube: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getVideo(videoCode: "mAqXHVxAwOk")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getVideo(videoCode:String){
        let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
        embedYoutube.loadRequest(URLRequest(url: url!))
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
