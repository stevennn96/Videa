//
//  IntroductionViewController.swift
//  test
//
//  Created by Sia Feri Santos on 22/08/18.
//  Copyright © 2018 Sia Feri Santos. All rights reserved.
//

import UIKit

class IntroductionViewController: UIViewController {

    @IBAction func submitButton(_ sender: Any) {
        performSegue(withIdentifier: "goToHome", sender: self)
    }
    
    @IBOutlet weak var embedYoutube: UIWebView!
    
    
    func getVideo(videoCode:String){
        let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
        embedYoutube.loadRequest(URLRequest(url: url!))
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getVideo(videoCode: "K1u0QvZD4v0")
        // Do any additional setup after loading the view.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
