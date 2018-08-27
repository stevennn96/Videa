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

class ProfileViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var tapTochangeImage: UIButton!
    
    var imagepicker: UIImagePickerController!
    
    override func viewDidLoad() {
        tapTochangeImage.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
        
        imagepicker = UIImagePickerController()
        imagepicker.allowsEditing = true
        imagepicker.sourceType = .photoLibrary
        imagepicker.delegate = self
        
        super.viewDidLoad()
    }
    @objc func openImagePicker(_ sender:Any){
        self.present(imagepicker, animated: true, completion: nil)
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        guard let username = usernameOutlet.text else {return}
        guard let image = imageView.image else {return}
        
        self.uploadProfileImage(image) { url in
            if url != nil {
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                changeRequest?.photoURL = url
                
                changeRequest?.commitChanges { error in
                    if error == nil {
                        print("User display name changed!")
                        
                        self.saveProfile(username: username, profileImageURL: url!) { success in
                            if success {
                                print("URLNYA ADALAH : \(url)")
                            }
                        }
                        self.performSegue(withIdentifier: "ProfileToChallenge", sender: self)
                        
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
    
    func saveProfile(username:String, profileImageURL:URL, completion: @escaping ((_ success:Bool)->())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let databaseRef = Database.database().reference().child("users/profile/\(uid)")
        
        let userObject = [
            "username": username,
            "photoURL": profileImageURL.absoluteString
            ] as [String:Any]
        
        databaseRef.setValue(userObject) { error, ref in
            completion(error == nil)
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

