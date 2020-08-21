//
//  CardViewModel.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/3/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class CardViewModel {
    
    private let user : User
    
    private var indexPhoto = 0
    
    var details : NSAttributedString
    
    var age : Int {
        return user.age
    }
    
    var photo : UIImage?
    
//    var firstPhoto : UIImage {
//        return user.photos.first!
//    }
    
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
    
//    func nextPhoto() {
//        guard indexPhoto < user.photos.count - 1 else { return }
//        indexPhoto += 1
//        self.photo = self.user.photos[indexPhoto]
//    }
//
//    func previousPhoto() {
//        guard indexPhoto > 0 else { return }
//        indexPhoto -= 1
//        self.photo = self.user.photos[indexPhoto]
//    }
    
}
