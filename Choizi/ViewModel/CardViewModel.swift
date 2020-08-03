//
//  CardViewModel.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/3/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

struct CardViewModel {
    
    private let user : User
    
    var details : NSAttributedString
    
    var age : Int {
        return user.age
    }
    
    var photos : [UIImage] {
        return user.photos
    }
    
    init(user: User) {
        self.user = user
        let attributed = NSMutableAttributedString(string: user.name, attributes: [
                                                    .font: UIFont.systemFont(ofSize: 30, weight: .heavy),
                                                    .foregroundColor: UIColor.white])
        attributed.append(NSAttributedString.init(string: "  \(user.age)",
                                                  attributes: [
                                                    .font: UIFont.systemFont(ofSize: 22),
                                                    .foregroundColor : UIColor.white]))
        self.details = attributed
        
    }
    
}
