//
//  IntroductionViewController.swift
//  Videa
//
//  Created by Steven on 26/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class IntroductionViewController: UIViewController {

    @IBOutlet weak var titleImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel1: UILabel!
    
    @IBOutlet weak var descriptionLabel2: UILabel!
    
    @IBOutlet weak var embedYoutube: UIWebView!
    
    var taskToSave: Task?
    
    func getVideo(videoCode:String){
        let url = URL(string: "http://www.youtube.com/embed/\(videoCode)")
        embedYoutube.loadRequest(URLRequest(url: url!))
    }
    
    @IBAction func letsDoItPressed(_ sender: Any) {
        taskToSave = Task(taskName: "Introduction", taskDone: 0, taskReq: 3, todoList: [Todo(description: "Get 10 views", targetNumber: 10, completed: "false"), Todo(description: "Get 5 likes", targetNumber: 5, completed: "false"), Todo(description: "Get 2 comments", targetNumber: 2, completed: "false")], videoLink: "")
        tasks.append(taskToSave!)
        
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.commitChanges(completion: { error in
            if error == nil {
                print ("Success")
                
                self.saveTask(taskName: (self.taskToSave?.taskName)!, taskDone: (self.taskToSave?.taskDone)!, taskReq: (self.taskToSave?.taskReq)!, videoLink: (self.taskToSave?.videoLink)!) { success in
                    if success {
                        print("Berhasil")
                    } else {
                        print("Error")
                    }
                    
                }
            }
        })
        
        performSegue(withIdentifier: "goToHome", sender: self)
    }
    
    func saveTask(taskName: String, taskDone: Int, taskReq: Int, videoLink: String, completion: @escaping ((_ success:Bool)->())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let databaseRef = Database.database().reference().child("users/task/\(uid)")
        
        let taskObject = [
            "taskName": taskName,
            "taskReq": taskReq,
            "taskDone": taskDone,
//            "todoList": todoList,
            "videoLink": videoLink
        ] as [String:Any]
        
        databaseRef.setValue(taskObject) { error, ref in
            completion(error == nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getVideo(videoCode: "K1u0QvZD4v0")
        
        titleLabel.text = "Introduction"
        descriptionLabel1.text = "Buat video yang mengenalkan channel kamu itu apa. kamu bisa jelaskan konten yang akan kamu upload di channel kamu. Menjadi seorang youtuber sukses itu perlu usaha keras dan strategi pintar agar Anda bisa mencapai kesuksesan."
        descriptionLabel2.text = "Berikut beberapa tips yang bisa Anda lakukan untuk bisa menjadi youtuber yang sukses : 1.Konsisten hanya pada Satu Kategori. 2. Menentukan siapa audience Anda. 3.Membuat video yang berkualitas dan kreatif. 4.Optimasi judul dan gambar thumbnail. 5.Memiliki Ciri Khas. 6. Berkomunikasi dengan Subscriber"
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
