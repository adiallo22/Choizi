//
//  ProfileViewModel.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/26/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

struct ProfileViewModel {
    
    private let user : User
    
    var imagesCount : Int {
        return user.images.count
    }
    
    var userInfo : NSAttributedString {
        let info = NSMutableAttributedString(string: user.name, attributes: [.font: UIFont.boldSystemFont(ofSize: 26)])
        info.append(NSAttributedString(string: "  -  \(user.age)", attributes: [.font: UIFont.systemFont(ofSize: 24)]))
        return info
    }
    
    var bio : String {
        return user.bio
    }
    
    var profession : String {
        return user.profession
    }
    
    init(user: User) {
        self.user = user
    }
    
}
