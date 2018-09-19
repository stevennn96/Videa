//
//  TestSimpenDataViewController.swift
//  Videa
//
//  Created by Sia Feri Santos on 29/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class TestSimpenDataViewController: UIViewController {

    @IBOutlet weak var levelOutlet: UILabel!
    @IBOutlet weak var progressOutlet: UILabel!
    @IBOutlet weak var expOutlet: UILabel!

    @IBAction func saveButton(_ sender: Any) {
        performSegue(withIdentifier: "Coba2", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let level = levelOutlet.text else {return}
        guard let progress = progressOutlet.text else {return}
        guard let expUser = expOutlet.text else {return}
        
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.commitChanges {error in
            if error == nil {
                print("Succes")
                
                self.saveData(level: level, progress: progress, exp:  expUser)
                {succes in
                    if succes {
                        print("Berhasil")
                    }
                    
                }
            }else {
                print("error")
            }
        }

    }
    
    
    func saveData(level: String, progress: String, exp:String, completion : @escaping ((_ success:Bool)->())) {
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let databasref = Database.database().reference().child("Gamification/user/\(uid)")
        
        let userData = [
            "levelUser" : level,
            "progressUser" : progress,
            "expUser": exp
        ]as [String:Any]
        databasref.setValue(userData){
            error, ref in completion(error == nil)
        }
    }
}
