//
//  ComedyLevelContentViewController.swift
//  Videa
//
//  Created by Steven on 26/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit

class ComedyLevelContentViewController: UIViewController {

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
            titleLabel.text = "Parodi"
            description1Label.text = "Buatlah video yang dibuat dengan cara memelesetkan, memberikan komentar atas karya asli dengan cara yang lucu atau dengan bahasa satire. "
            description2Label.text = "Caranya gimana? contohnya gimana? Ini tips nya!\n1. Cari-cari instruments-instruments musik\n2. Pahami instrumentnya lalu masukan lyrik baru yang sesuai dengan instrumen yang anda punya. Contoh: lagu “sik-asik” dari ayu ting-ting bisa anda rubah dengan “sok-gosok” atau yang lainya.\n3. Ingatlah satu hal bukan satu rekaman tapi puluhan rekaman sedkit demi sedikit tiap-tiap kata\n4. kualitas lensa kamera minimal yang 5 mp\n5. Gabungin video dengan musiknya\n6. Kamu bisa tambah visual effect agar lebih menarik!"
            getVideo(videoCode: "hsF6-yvqM4s")
        } else if tag == 2{
            titleImage.image = UIImage(named: "")
            titleLabel.text = "Comedy Horror"
            description1Label.text = "Buatlah video bergenre comedey dan juga horror. Buatlah video bercerita seram dan juga lucu, buatlah suasana cerita menegangkan sekaligus menghibur. Buat sekreatif mungkin ya! kamu bisa tambah visual effect agar lebih menarik! Kamu juga bisa buat short movie"
            description2Label.text = "Tips: tambahkan karakter lucu atau pelawak untuk menghibur audience"
            getVideo(videoCode: "qkCRVwwuA40")
        } else if tag == 3{
            titleImage.image = UIImage(named: "")
            titleLabel.text = "Comedy Romance"
            description1Label.text = "Comedy romance itu video bergenre comedy dan juga romance. Buat short movie berceritakan romance tapi selipkan unsur comedy nya juga ya kedalam video kamu! Short movie akan lebih menarik dan menghibur apabila dipadukan dua genre"
            description2Label.text = "Buat short movie berdurasi 10 – 15 menit ya!"
            getVideo(videoCode: "3DRVeyCLwik")
        } else if tag == 4{
            titleImage.image = UIImage(named: "")
            titleLabel.text = "Comedy Motivasi"
            description1Label.text = "Buatlah video comedy yang menginspirasi atau memotivasi audience kamu ke dalam hal positif. Buat sekreatif mungkin ya! kamu bisa tambah visual effect agar lebih menarik! Kamu juga bisa buat short movie"
            description2Label.text = "Good Luck!"
            getVideo(videoCode: "NBfza0yteJg")
        } else if tag == 5{
            titleImage.image = UIImage(named: "")
            titleLabel.text = "Vlog"
            description1Label.text = "Vlog adalah sebuah video yang mempunyai tema tertentu yang dikemas dalam konsep dokumentasi jurnalistik dan dimuat dalam sebuah website. Biasanya video vlog berisi tentang ketertarikan, opini maupun pikiran, hampir mirip dengan tayangan televisi, walaupun dalam proses pembuatannya tidak serumit pembuatan tayangan televisi. Istilah vlog sendiri merupakan singakatan dari video blog."
            description2Label.text = ""
            getVideo(videoCode: "8Z3rHMCAEtc")
        } else if tag == 6{
            titleImage.image = UIImage(named: "")
            titleLabel.text = "Stand up comedy"
            description1Label.text = "Buatlah video dimana kamu harus menjadi pelawak tunggal yang menceritakan hal - hal lucu seorang diri di depan audience. Biasanya para pelawak tunggal membawakan materi mereka dengan gaya monolog, walaupun ada beberapa jurus yang mengharuskan mereka berinteraksi dengan penonton."
            description2Label.text = ""
            getVideo(videoCode: "qonMgEaU0ZQ")
        } else if tag == 7{
            titleImage.image = UIImage(named: "")
            titleLabel.text = "Impersonate Famous Person"
            description1Label.text = "Impersonate Video adalah kamu harus menirukan seseorang, menirukan gaya bicara, kalimat yang dia katakan, atau bisa juga language boy yang biasa orang itu gunakan. Challenge kali ini kamu harus menirukan famous people boleh satu maupun lebih, tapi lebbih dari satu akan lebih baik guys!"
            description2Label.text = ""
            getVideo(videoCode: "elWo5LjjEMg")
        } else if tag == 8{
            titleImage.image = UIImage(named: "")
            titleLabel.text = "Do Challenge"
            description1Label.text = "Buatlah sebuah satu challenge apa saja yag kamu sukai, audience akan lebih tertarik apabila kamu melakukan challenge yang sedang trendy saat ini atau yang umum."
            description2Label.text = "Contoh challenge yang umum adalah:\n1. Makan makanan pedes, kamu bisa makan makanan pedes yang sedang trendy (di restaurant maupun yang instan)\n2. Try Not To Laugh, kamu bisa merekam kamu sedang menonton video lucu yang sedang viral dan berusaha tidak ketawa karena video tersebut. Jangan lupa edit video kamu dengam menampilkan video yang sedang kamu tonton ya\n3. Whisper challenge, kamu butuh teman untuk melakukan challenge ini ya!\n4. Dan lain - lain.\nKamu tidak perlu melakukan challenge - challenge diatas, kamu bebas ingin melakukan challenge apa\nGood Luck!"
            getVideo(videoCode: "qonMgEaU0ZQ")
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
