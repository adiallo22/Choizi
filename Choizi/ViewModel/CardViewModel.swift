//
//  CardViewModel.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/3/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class CardViewModel {
    
    let user : User
    
    private var indexPhoto = 0
    
    var index : Int { return indexPhoto }
    
    var details : NSAttributedString
    
    var age : Int {
        return user.age
    }
    
    var frontPhoto : URL?
    
    var photos : [String]
    
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
        self.photos = user.images
        self.frontPhoto = URL.init(string: self.photos[0])
    }
    
    func nextPhoto() {
        guard indexPhoto < photos.count - 1 else { return }
        indexPhoto += 1
        frontPhoto = URL.init(string: photos[indexPhoto])
    }

    func previousPhoto() {
        guard indexPhoto > 0 else { return }
        indexPhoto -= 1
        frontPhoto = URL.init(string: photos[indexPhoto])
    }
    
}
