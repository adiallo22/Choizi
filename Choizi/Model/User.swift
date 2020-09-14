//
//  User.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/3/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit.UIImage

struct User {
    
    var name : String
    var age : Int
    var email : String
    var images : [String]
    var uid : String
    var bio : String
    var profession : String
    var seekingMinAge : Int
    var seekingMaxAge : Int
    
    init(value : [String:Any]) {
        self.name = value["fullname"] as? String ?? ""
        self.age = value["age"] as? Int ?? 18
        self.email = value["email"] as? String ?? ""
        self.images = value["images"] as? [String] ?? [String]()
        self.uid = value["uid"] as? String ?? ""
        self.bio = value["bio"] as? String ?? ""
        self.profession = value["profession"] as? String ?? ""
        self.seekingMinAge = value["seekingMinAge"] as? Int ?? 18
        self.seekingMaxAge = value["seekingMaxAge"] as? Int ?? 45
    }
    
}
