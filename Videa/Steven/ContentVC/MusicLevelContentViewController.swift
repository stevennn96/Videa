//
//  MusicLevelContentViewController.swift
//  Videa
//
//  Created by Steven on 26/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit

class MusicLevelContentViewController: UIViewController {

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
            titleImage.image = UIImage(named: "music title")
            titleLabel.text = "Cover Lagu"
            description1Label.text = "Kategori ini cocok untuk Anda yang hobi bernyanyi atau memainkan alat musik bahkan menciptakan lagu. Youtube bisa dijadikan media untuk Anda menunjukan bakat Anda dalam bidang musik seperti membuat cover lagu favorit Anda baik dengan kemampuan bernyanyi Anda baik solo ataupun kolaborasi, bisa juga dengan bermain alat musik."
            description2Label.text = "Tapi ada beberapa hal yang harus kamu perhatikan terlebih dahulu.\nSecara hukum, dan juga secara teknis:\n1. Biarkan lirik tetap orisinil, jangan ditambah, dikurang, atau diubah\n2. Nah ini yang paling penting guys! Sebenarnya, monetisasi (meng-uang-kan) video cover lagu yang kita upload di Youtube harus ada mechanical rights-nya (Lisensi atas Hak Mekanikal).\n3. Kualitas audio dan video harus bagus dan niat.\n4. Bikin versi yang outstanding"
            getVideo(videoCode: "g69RW4vmSK4")
        } else if tag == 2{
            titleImage.image = UIImage(named: "coverlagudenganimprovisasi")
            titleLabel.text = "Cover Lagu dengan Improvisasi"
            description1Label.text = "Improvisasi Musik adalah kemampuan seseorang melakukan atau mengembangkan sesuatu menjadi lebih dan lebih tanpa ada persiapan atau arahan sebelumnya, Biasanya, seorang musisi profesional mampu melakukan improvisasi dengan mengubah musik menjadi lebih bernilai."
            description2Label.text = "Tapi ada beberapa hal yang harus kamu perhatikan terlebih dahulu:\n1. Jangan terlalu banyak improvisasi, Keep it Simple!\n2. Bikin versi yang outstanding"
            getVideo(videoCode: "F2EIMU3ZCqg")
        } else if tag == 3{
            titleLabel.text = "collaborationcoverlagu"
            description1Label.text = "Kolaborasi musik adalah bentuk kerjasama, interaksi, kompromi dua orang atau lebih  pemusik  yang terkait dalam satu konten yang menerima akibat dan manfaat positif antar musik masing – masing agar memperoleh hasil musik yang lebih mengesankan."
            description2Label.text = "Ada beberapa hal yang harus kamu perhatikan terlebih dahulu:"
            getVideo(videoCode: "uzgp65UnPxA")
        } else if tag == 4{
            titleImage.image = UIImage(named: "coverlaguyangsedangtrendy")
            titleLabel.text = "Cover Lagu yang sedang Trendy"
            description1Label.text = "Buatlah Cover lagu yang sedang hits/trendy di jaman sekarang! Kamu bisa cover lagu Indonesia atau lagu luar loh! Meng-cover lagu yang sedang trendy bisa menambah daya tarik viewers kalian juga karena lagu yang kalian cover sudah jelas mereka akan tahu!"
            description2Label.text = "Good Luck!"
            getVideo(videoCode: "nH7gHCO3oik")
        } else if tag == 5{
            titleImage.image = UIImage(named: "mashup:medley")
            titleLabel.text = "MashUp / Medley Cover Lagu"
            description1Label.text = "Sebuah lagu atau komposisi yang dikreasikan dengan mengabungkan dua atau lebih lagu-lagu, biasanya dengan melapisi jalur vokal dari satu lagu dan ditumpuk dengan lagu yang lainnya. Sehingga jika didengarkan dengan seksama dapat menghasilkan irama dan melodi yang harmoni"
            description2Label.text = "Ada tips nya nih!\n1. Tentukan genre lagu yang akan dibuat (lebih baik genre lagu yang disukai)\n2. Pilih 2 lagu atau lebih yang akan di mash up, cari lagu nya yang chordnya sama ya!\n Misal: lagu pertama dari G, maka cari lagu kedua yang memiliki chord dasar G\nGood Luck!"
            getVideo(videoCode: "7m3o5LuFKxg")
        } else if tag == 6{
            titleImage.image = UIImage(named: "coverlagudenganinstrumentsendiri")
            titleLabel.text = "Cover Lagu Instrument Sendiri"
            description1Label.text = "Buatlah cover lagu yang kalian minati dengan komposisi atau rekaman musik dalam bentuk apapun yang menghasilkan cover lagu yang berbeda dan memiliki ciri khas tersendiri."
            description2Label.text = "Tips alat music yang dapat digunakan:\n1. Gitar\n2. Piano\n3. Disc jockey (DJ)\n4. Atau alat music lain nya."
            getVideo(videoCode: "AAsDUIxuPzE")
        } else if tag == 7{
            titleImage.image = UIImage(named: "coverlagutranslate")
            titleLabel.text = "Cover Translate Lagu"
            description1Label.text = "Kamu bisa menyanyikan lagu apapun dengan bahasa yang berbeda. Contoh kamu bisa menyanyikan lagu Bahasa Indonesia ke dalam Bahasa Inggris atau sebaliknya. Cover lagu seperti ini dapat menarik perhatian audience karena mereka penasaran lagu yang akan kamu bawakan akan seperti apa"
            description2Label.text = "Ini contoh cover lagu dari Bahasa Inggris ke Bahasa Indonesia ya"
            getVideo(videoCode: "Zubiz8K9_xE")
        } else if tag == 8{
            titleImage.image = UIImage(named: "acapella")
            titleLabel.text = "Cover Lagu Acapella"
            description1Label.text = "Acapella adalah musik yang dinyanyikan secara solo atau grup hanya dengan menggunakan vokal atau tanpa menggunakan instrumen musik pada umumnya. Pada acapella umumnya ditemui harmonisasi vokal dan beatbox."
            description2Label.text = "Ada sedikit tips nih, Software yang bisa digunakan \n1. Audacity\n2. Acapella.exe"
            getVideo(videoCode: "dV0F8PNiBhE")
        } else if tag == 9{
            titleImage.image = UIImage(named: "ciptainlagusendiri")
            titleLabel.text = "Ciptain Lagu Sendiri"
            description1Label.text = "Kamu sudah berhasil melewati 8 challenge dan cukup mengcover banyak lagu, sekarang giliran kamu menciptakan lagu orisinil!"
            description2Label.text = "Ini langkah - langkah membuat lagu ciptaan sendiri:\n1. Tentukan tipe lagu\n2. Tentukan genre lagu (pop, rock, hip hop, r&b, jazz, dll)\n3. Buatlah lirik lagu yang beralur dan memiliki arti kata - kata yang dalam dan bermakna.\n4. Tentukan struktur lagu (Intro, Verse, Chorus, dll)\n5. Tentukan kunci dasar sebagai patokan range nada – nada yang dapat dijangkau.\n6. Buatlah nada lagu (Intro, Middle, Outro)\n7. Finish, nyanyikanlah lagu secara penuh\n8. Review lagu yang telah kamu buat"
            getVideo(videoCode: "M7E7QrFaffY")
        }
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
