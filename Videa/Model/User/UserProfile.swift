//
//  UserProfile.swift
//  Videa
//
//  Created by Sia Feri Santos on 28/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import Foundation

class UserProfile {
    var uid:String
    var username:String
    var photoURL:URL
    
    init(uid:String, username:String,photoURL:URL) {
        self.uid = uid
        self.photoURL = photoURL
        self.username = username
    }
}
