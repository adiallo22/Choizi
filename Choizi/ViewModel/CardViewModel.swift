//
//  CardViewModel.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/3/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit.UIImage

struct CardViewModel {
    
    private let user : User
    
    var name : String {
        return user.name
    }
    
    var age : Int {
        return user.age
    }
    
    var photos : [UIImage] {
        return user.photos
    }
    
    init(user: User) {
        self.user = user
    }
    
}
