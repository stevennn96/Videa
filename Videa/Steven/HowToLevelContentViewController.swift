//
//  HowToLevelContentViewController.swift
//  Videa
//
//  Created by Steven on 26/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit

class HowToLevelContentViewController: UIViewController {

    @IBOutlet weak var titleImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var description1Label: UILabel!
    
    @IBOutlet weak var description2Label: UILabel!
    
    @IBOutlet weak var embedYoutube: UIWebView!
    
    var tag: Int = 0
    
    
    func getVideo(videoCode:String){
        let url = URL(string: "http://www.youtube.com/embed/\(videoCode)")
        embedYoutube.loadRequest(URLRequest(url: url!))
    }
    
    @IBAction func letsDoItPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToHome", sender: self)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if tag == 1{
            titleImage.image = UIImage(named: "")
            titleLabel.text = "How to be a Youtuber"
            description1Label.text = "Kamu harus membuat video tentang bagaimana menjadi pemula di dunia youtube. Menjelaskan bagaimana memelihara dan merawat akun youtube.  Ditengah ketatnya persaingan, sekarang semakin banyak youtuber-youtuber baru bermunculan namun sayangnya tidak semua youtuber bisa sukses dan menjadikan YouTube sebagai karirnya."
            description2Label.text = "Inilah beberapa faktor terpenting dalam engagement sebuah channel YouTube:\n1. Jumlah waktu kunjungan (watch time)\n2. Jumlah views pada sebuah video.\n3. Rasio like dan dislike\n4. Subscriber dan social share.\n5. Komentar.\nGood luck!"
            getVideo(videoCode: "a3sASBC6XAQ")
        } else if tag == 2{
            titleImage.image = UIImage(named: "")
            titleLabel.text = "How to be a Blogger"
            description1Label.text = "Kamu harus membuat video tentang bagaimana seseorang bisa menjadi Blogger. Apa itu Blogger? Blogger adalah istilah seseorang yang menulis blog, seseorang yang suka menulis dan ditampilkan di web/ internet. Yang terpenting dari seorang blogger adalah harus memiliki rasa ketertarikan dalam menulis karena dalam menjadi blogger yang dikerjakan hanya menulis."
            description2Label.text = "Good luck!"
            getVideo(videoCode: "")
        } else if tag == 3{
            titleImage.image = UIImage(named: "")
            titleLabel.text = "How to be a Selebgram"
            description1Label.text = "Kamu harus membuat video tentang apa yang harus dilakukan seseorang untuk menjadi seorang selebgram. Selebgram adalah istilah untuk mereka pengguna akun Instagram yang terkenal di situs jejaring sosial tersebut. Istilah selebgram berasal dari kata selebritis dan Instagram yang bisa berarti selebritis yang cuma ngetop di Instagram."
            description2Label.text = ""
            getVideo(videoCode: "")
        } else if tag == 4{
            titleImage.image = UIImage(named: "")
            titleLabel.text = "How to make you favorite food!"
            description1Label.text = "Kamu buat video tentang bagaimana cara membuat makanan kesukaan kamu! Kamu bisa memulai video nya dengan belanja bahan nya ataupun langsung memulai membuat makanan kesukaan kamu. Dan kamu bisa membuat video nya menerupai vlog atau tutorial, jangan lupa kualitas video harus bagus ya"
            description2Label.text = "Good Luck!"
            getVideo(videoCode: "FLd00Bx4tOk")
        } else if tag == 5{
            titleImage.image = UIImage(named: "")
            titleLabel.text = "How to make your favorite Indonesian food!"
            description1Label.text = "Kamu buat video tentang bagaimana cara membuat makanan khas Indonesia kesukaan kamu! Kamu bisa memulai video nya dengan belanja bahan nya ataupun langsung memulai membuat makanan kesukaan kamu. Dan kamu bisa membuat video nya menyerupai vlog atau tutorial, jangan lupa kualitas video harus bagus yaa. Jangan lupa kamu bisa tambahkan informasi – informasi tentang makanan khas Indonesia kesukaan kamu agar lebih menarik dan informatif"
            description2Label.text = "Good Luck!"
            getVideo(videoCode: "igBL4UsGMLo")
        } else if tag == 6{
            titleImage.image = UIImage(named: "")
            titleLabel.text = "How to make your favorite spicy food!"
            description1Label.text = "Buatlah video tentang bagaimana kamu membuat makanan pedas kesukaan mu! Kamu harus melakukan research bahan dan cara membuatnya setelah itu kamu pastikan dulu membuat dengan cara tersebut menghasilkan rasa pedas yang kamu inginkan. Agar lebih informatif kamu bisa menjelaskan tingkatan pedas yang kamu buat dan kamu sukai agar audience bisa menyesuaikan makanan kamu."
            description2Label.text = "Good Luck!"
            getVideo(videoCode: "XY_NVvfCuzI")
        } else if tag == 7{
            titleImage.image = UIImage(named: "")
            titleLabel.text = "How to style like your favorite style!"
            description1Label.text = "Kamu harus membuat video menceritakan style dan model apa yang kamu suka, kamu juga bisa sharing baju, celana, sepatu, dan aksesoris lain nya kamu beli dimana dan kenapa menyukai style seperti itu. Dan jangan lupa yang kamu kenakan juga outfit yang sesuai style kamu agar audience lebih mengerti dan kebayang dengan style kamu "
            description2Label.text = "Good Luck!"
            getVideo(videoCode: "HVwRbGASJOY")
        } else if tag == 8{
            titleImage.image = UIImage(named: "")
            titleLabel.text = "How to mix and match"
            description1Label.text = "Mix and match adalah menyesuaikan outfit kamu dari atas sampai bawah. Kamu bisa menyesuaikan baju, celana, sepatu, dan aksesoris yang akan kamu pakai itu cocok dan nyaman digunakan."
            description2Label.text = "Nah, kamu harus membuat video meng mix and match outfit, boleh kamu membuat vlog dari kamu belanja maupun kamu sesuaikan dengan pakaian yang kamu punya"
            getVideo(videoCode: "bAQxoBRDCBQ")
        } 
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
