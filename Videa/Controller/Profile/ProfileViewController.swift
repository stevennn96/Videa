//
//  ProfileViewController.swift
//  Videa
//
//  Created by Sia Feri Santos on 24/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import Kingfisher

class ProfileViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var tapTochangeImage: UIButton!
    @IBOutlet weak var quotesOutlet: UITextView!
    
    private var postChildListener: UInt?
    var imagepicker: UIImagePickerController!
    var completed = false
    
    override func viewDidLoad() {
        
        tapTochangeImage.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
        imagepicker = UIImagePickerController()
        imagepicker.allowsEditing = true
        imagepicker.sourceType = .photoLibrary
        imagepicker.delegate = self
        usernameOutlet.delegate = self
        quotesOutlet.delegate = self
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.layer.cornerRadius = imageView.frame.size.height/2
        imageView.clipsToBounds = true
        super.viewDidLoad()
        bacaData()
        
        
        self.getData(){ (success) in
            // if success true
            print("data")
        }
        
    }
    
    func getData(onComplete: @escaping (Bool) -> ()){
        //get data
        onComplete(true)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //textview
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n"){
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    //textview placeholder
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(textView.text == "Your Favorite Quotes"){
            textView.text = ""
            quotesOutlet.textColor = UIColor.black
        };textView.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if(textView.text == "")
        {
            textView.text = "Your Favorite Quotes"
            quotesOutlet.textColor = #colorLiteral(red: 0.780488193, green: 0.7801764607, blue: 0.8018243313, alpha: 1)
        };textView.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    @objc func openImagePicker(_ sender:Any){
        self.present(imagepicker, animated: true, completion: nil)
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        guard let username = usernameOutlet.text else {return}
        guard let image = imageView.image else {return}
        guard let quotes = quotesOutlet.text else {return}
        
        applyLoadingScreen()
        self.uploadProfileImage(image) { url in
            if url != nil {
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                changeRequest?.photoURL = url
                
                changeRequest?.commitChanges { error in
                    if error == nil {
                        print("User display name changed!")
                        
                        self.saveProfile(username: username, profileImageURL: url! , quotes: quotes) { success in
                            if success {
                                self.completed = true
                                return
                            }
                        }
                        self.performSegue(withIdentifier: "EditProfileSuccess", sender: self)
                        
                    } else {
                        print("Error: \(error!.localizedDescription)")
                    }
                }
            } else {
                // Error unable to upload profile image
            }
            
        }
        
    }

    func uploadProfileImage(_ image:UIImage, completion: @escaping ((_ url:URL?)->())) {
        
        completed = false
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("user/\(uid)")
        
        guard let imageData = UIImageJPEGRepresentation(image, 0.99) else { return }
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        storageRef.putData(imageData, metadata: metaData) { metaData, error in
            if error == nil, metaData != nil {
                if let url = metaData?.downloadURL() {
                    completion(url)
                } else {
                    completion(nil)
                }
                // success!
            } else {
                // failed
                completion(nil)
            }
        }
    }
    
    func saveProfile(username:String, profileImageURL:URL, quotes:String, completion: @escaping ((_ success:Bool)->())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let databaseRef = Database.database().reference().child("users/profile/\(uid)")
        
        let userObject = [
            "username": username,
            "photoURL": profileImageURL.absoluteString,
            "quotes" : quotes
            ] as [String:Any]
        
        databaseRef.setValue(userObject) { error, ref in
            completion(error == nil)
        }
    }
    
    func bacaData() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        postChildListener = Database.database().reference().child("users/profile/\(uid)").observe(.value) {(snapshot: DataSnapshot) in
            if snapshot.exists() {
                let data = snapshot.value as! NSDictionary
                let key = snapshot.key
                
                let username = data["username"] as! String
                let photoURL = data["photoURL"] as! String
                let quotesP = data["quotes"] as! String
                self.usernameOutlet.text = username
                self.quotesOutlet.text = quotesP
                self.quotesOutlet.textColor = UIColor.black
                self.imageView.kf.setImage(with: URL(string: photoURL), placeholder: nil, options: nil, progressBlock: nil, completionHandler: {image, error, cacheType, imageUrl in }  )
            }
        }
        
    }
    
    func applyLoadingScreen() {
        
        let loadingImageView = UIImageView()
        let keyWindow = UIApplication.shared.keyWindow
        
        DispatchQueue.main.async {
            
            loadingImageView.frame = CGRect(x: 0, y: 0, width: (keyWindow?.frame.width)!, height: (keyWindow?.frame.height)!)
            loadingImageView.image = UIImage(named: "LoadingScreen")
            
            keyWindow?.addSubview(loadingImageView)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                while self.completed == false {
                    continue
                }
                
                loadingImageView.removeFromSuperview()
            }
        }
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.imageView.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}

