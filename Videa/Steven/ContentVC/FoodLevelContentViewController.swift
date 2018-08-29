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
            titleImage.image = UIImage(named: "reviewmakananyanglagitrendy")
            titleLabel.text = "Review Makanan yang lagi Trendy"
            description1Label.text = "Dalam review makanan, kamu harus mencoba makanan tersebut. Ulangi memakan makanan tersebut ketika kamu sudah terlalu lama tidak merasakannya. Nikmati perlahan hingga kamu menemukan detail makanan tersebut. Contoh detail tentang makanan adalah rasa, tekstur dan bau makanan tersebut."
            description2Label.text = "Ada tips nya nih sebelum kamu mereview!\n1. Semakin banyak menu yang kamu coba, pengalaman kamu akan semakin bertambah.  Kamu dapat menguraikan komentar kamu didepan kamera dengan ekspresi -ekspresi tertentu agar menguatkan review.\n2. Kamu juga perlu memperhatikan keadaan sekitar lokasi tempat kamu makan. Kamu bisa mendeskripsikan tentang kebersihan lokasi, kestrategisan lokasi, dan tata letak tempat dan peralatan makan yang tersedia.\n3. Makanan yang disajikan harus menarik. Kemenarikan tersebut dapat dilihat dari segi perpaduan warna makanan dan garnis atau pemanis makanan.\n4. Perhatikan suhu makanan, jangan sajikan makanan hangat saat sudah dingin.\n5. Review tingkat kematangan makanan\n6. Bersikaplah baik dan ramah, terhadap pelayan maupun sesama pengunjung"
            getVideo(videoCode: "GvVIC3I3oO0")
        } else if tag == 2{
            titleImage.image = UIImage(named: "mukbang")
            titleLabel.text = "Mukbang"
            description1Label.text = "Mukbang merupakan siaran audiovisual yang ditayangkan secara online, dimana pembawa acara/host/food vlogger yang bersangkutan akan menikmati sejumlah makanan dalam kuantitas besar sambil berinteraksi dengan penontonnya."
            description2Label.text = "Ada tips untuk mukbang pemula nih!\n1. Pilih makanan yang kamu benar - benar sukai\n2. Siapkan alat2 yang sekiranya kamu butuhkan\n3. Make sure kamu memiliki spund dan audio yang bagus\n4. Siapkan point pembicaraan yang ingin disampaikan ke viewers\n5. BE YOURSELF!"
            getVideo(videoCode: "zMXfmj5mQ04")
        } else if tag == 3{
            titleImage.image = UIImage(named: "asmr")
            titleLabel.text = "ASMR"
            description1Label.text = "ASMR ini adalah video yang mengfokuskan pada audio/ suara dari cara kamu memakan makanan tersebut.  ASMR ini berguna banget buat orang insomnia. Berguna pula untuk orang yang sedah gelisah ataupun ga tenang, karna ini bersifat relaksasi. Kualitas suara dalam video ASMR tidak main-main loh! Suaranya terdengar sangat detail. Bahkan suara teksturnya terdengar sangat jelas."
            description2Label.text = "Ada tips untuk membuat video ASMR nih!\n1. Gunakan mic/ earphone yang kamu punya agar memperjelas suaranya\n2. Lakukan gerakan secara perlahan dan be quite\n3. Saat meng-edit video jangan ragu untuk memperkeras suara nya ya!"
            getVideo(videoCode: "kU8LEroVW44&t=78s")
        } else if tag == 4{
            titleImage.image = UIImage(named: "mukbangdanasmr")
            titleLabel.text = "Mukbang dan ASMR"
            description1Label.text = "Seperti yang kamu sudah lakukan di challenge sebelumnya, challenge kali ini gabungkan Mukbang dan ASMR. Buatlah video memakan makanan dalam jumlah yang besar dan lakukanlah ASMR."
            description2Label.text = "Good Luck!"
            getVideo(videoCode: "a_WY2tuQ8dg")
        } else if tag == 5{
            titleImage.image = UIImage(named: "docollaboration")
            titleLabel.text = "Do Collaboration"
            description1Label.text = "Challenge kali ini, kamu bisa melakukan challenge ataupun Mukbang bersama teman kamu, kamu bisa mengajak satu atau dua teman kamu untuk berkolaborasi."
            description2Label.text = "Good Luck!"
            getVideo(videoCode: "s9pSgJ34Umo")
        } else if tag == 6{
            titleImage.image = UIImage(named: "samyangchallenge")
            titleLabel.text = "Samyang Challenge"
            description1Label.text = "Samyang Challenge adalah tantangan buat makan Samyang dan tidak boleh minum sebelum habis. Beberapa Youtubers Indonesia gak ketinggalan buat melakukan Samyang Challenge. Dan ini contoh youtubers Indonesia melakukan samyang challenge."
            description2Label.text = "Good Luck!"
            getVideo(videoCode: "WKDuyEKni4o")
        } else if tag == 7{
            titleImage.image = UIImage(named: "oreochallenge")
            titleLabel.text = "Oreo Challenge"
            description1Label.text = "Oreo challenge memakan nya dengan cara mengarahkan oreo dari dahi hingga kemulut tanpa menggunakan tangan"
            description2Label.text = "Dan masih banyak oreo challenge lain nya yang orang lain buat sendiri , kamu bisa cek di youtube ya.\nGood Luck!"
            getVideo(videoCode: "WxGzpu4afSo")
        } else if tag == 8{
            titleImage.image = UIImage(named: "chubbybunnychallenge")
            titleLabel.text = "ChubbyBunnyChallenge"
            description1Label.text = "Chubby Bunny Challenge adalah sebuah challenge yang dilakukan dua orang untuk memasukkan marshmallow sebanyak-banyaknya ke dalam mulut. Siapa yang bisa memasukkan lebih banyak marshmallow dialah pemenangnya. Biasanya Chubby Bunny Challenge dilakukan sambil QnA atau obrolan chitchat sehingga menambah tantangan untuk mereka dan tantangan menjjadi lebih menarik."
            description2Label.text = "Good Luck!"
            getVideo(videoCode: "pFAb6YPBQxk")
        } else if tag == 9{
            titleImage.image = UIImage(named: "richeesechallenge")
            titleLabel.text = "Richeese Challenge"
            description1Label.text = "Richeese Challenge adalah dimana kamu memakan salah satu menu dari restaurant Richeese Factory dengan tingkat kepedasan yang dahsyat. Tingkat kepedasan dari Richeese Factory adalah level 1-5 yang biasanya orang gunakan sebagai Richeese Challenge adalah level 5. Richeese Challenge mirip dengan Samyang Challenge dilakukan tanpa minum sebelum habis."
            description2Label.text = "Good Luck!"
            getVideo(videoCode: "PqNhDlChSag")
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
