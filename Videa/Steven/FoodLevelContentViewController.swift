//
//  FoodLevelContentViewController.swift
//  Videa
//
//  Created by Steven on 26/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit

class FoodLevelContentViewController: UIViewController {

    
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
            titleLabel.text = "Review Makanan yang lagi Trendy"
            description1Label.text = "Dalam review makanan, kamu harus mencoba makanan tersebut. Ulangi memakan makanan tersebut ketika kamu sudah terlalu lama tidak merasakannya. Nikmati perlahan hingga kamu menemukan detail makanan tersebut. Contoh detail tentang makanan adalah rasa, tekstur dan bau makanan tersebut."
            description2Label.text = "Ada tips nya nih sebelum kamu mereview!\n1. Semakin banyak menu yang kamu coba, pengalaman kamu akan semakin bertambah.  Kamu dapat menguraikan komentar kamu didepan kamera dengan ekspresi -ekspresi tertentu agar menguatkan review.\n2. Kamu juga perlu memperhatikan keadaan sekitar lokasi tempat kamu makan. Kamu bisa mendeskripsikan tentang kebersihan lokasi, kestrategisan lokasi, dan tata letak tempat dan peralatan makan yang tersedia.\n3. Makanan yang disajikan harus menarik. Kemenarikan tersebut dapat dilihat dari segi perpaduan warna makanan dan garnis atau pemanis makanan.\n4. Perhatikan suhu makanan, jangan sajikan makanan hangat saat sudah dingin.\n5. Review tingkat kematangan makanan\n6. Bersikaplah baik dan ramah, terhadap pelayan maupun sesama pengunjung"
            getVideo(videoCode: "GvVIC3I3oO0")
        } else if tag == 2{
            titleImage.image = UIImage(named: "")
            titleLabel.text = "Mukbang"
            description1Label.text = "Mukbang merupakan siaran audiovisual yang ditayangkan secara online, dimana pembawa acara/host/food vlogger yang bersangkutan akan menikmati sejumlah makanan dalam kuantitas besar sambil berinteraksi dengan penontonnya."
            description2Label.text = "Ada tips untuk mukbang pemula nih!\n1. Pilih makanan yang kamu benar - benar sukai\n2. Siapkan alat2 yang sekiranya kamu butuhkan\n3. Make sure kamu memiliki spund dan audio yang bagus\n4. Siapkan point pembicaraan yang ingin disampaikan ke viewers\n5. BE YOURSELF!"
            getVideo(videoCode: "zMXfmj5mQ04")
        } else if tag == 3{
            titleImage.image = UIImage(named: "")
            titleLabel.text = "ASMR"
            description1Label.text = "ASMR ini adalah video yang mengfokuskan pada audio/ suara dari cara kamu memakan makanan tersebut.  ASMR ini berguna banget buat orang insomnia. Berguna pula untuk orang yang sedah gelisah ataupun ga tenang, karna ini bersifat relaksasi. Kualitas suara dalam video ASMR tidak main-main loh! Suaranya terdengar sangat detail. Bahkan suara teksturnya terdengar sangat jelas."
            description2Label.text = "Ada tips untuk membuat video ASMR nih!\n1. Gunakan mic/ earphone yang kamu punya agar memperjelas suaranya\n2. Lakukan gerakan secara perlahan dan be quite\n3. Saat meng-edit video jangan ragu untuk memperkeras suara nya ya!"
            getVideo(videoCode: "kU8LEroVW44&t=78s")
        } else if tag == 4{
            titleImage.image = UIImage(named: "")
            titleLabel.text = "Mukbang dan ASMR"
            description1Label.text = "Seperti yang kamu sudah lakukan di challenge sebelumnya, challenge kali ini gabungkan Mukbang dan ASMR. Buatlah video memakan makanan dalam jumlah yang besar dan lakukanlah ASMR."
            description2Label.text = "Good Luck!"
            getVideo(videoCode: "a_WY2tuQ8dg")
        } else if tag == 5{
            titleImage.image = UIImage(named: "")
            titleLabel.text = "Do challenge"
            description1Label.text = ""
            description2Label.text = ""
            getVideo(videoCode: "")
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
