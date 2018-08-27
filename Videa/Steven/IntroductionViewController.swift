//
//  IntroductionViewController.swift
//  Videa
//
//  Created by Steven on 26/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit

class IntroductionViewController: UIViewController {

    @IBOutlet weak var titleImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel1: UILabel!
    
    @IBOutlet weak var descriptionLabel2: UILabel!
    
    @IBOutlet weak var embedYoutube: UIWebView!
    
    func getVideo(videoCode:String){
        let url = URL(string: "http://www.youtube.com/embed/\(videoCode)")
        embedYoutube.loadRequest(URLRequest(url: url!))
    }
    
    @IBAction func letsDoItPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToHome", sender: self)
    }
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getVideo(videoCode: "K1u0QvZD4v0")
        
        titleLabel.text = "Introduction"
        descriptionLabel1.text = "Buat video yang mengenalkan channel kamu itu apa. kamu bisa jelaskan konten yang akan kamu upload di channel kamu. Menjadi seorang youtuber sukses itu perlu usaha keras dan strategi pintar agar Anda bisa mencapai kesuksesan."
        descriptionLabel2.text = "Berikut beberapa tips yang bisa Anda lakukan untuk bisa menjadi youtuber yang sukses :\n1. Konsisten hanya pada Satu Kategori\n2. Menentukan siapa audience Anda\n3. Membuat video yang berkualitas dan kreatif\n4. Optimasi judul dan gambar thumbnail\n5. Memiliki Ciri Khas\n6. Berkomunikasi dengan Subscriber"
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
