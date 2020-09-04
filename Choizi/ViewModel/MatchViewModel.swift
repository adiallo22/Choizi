//
//  MatchViewModel.swift
//  Choizi
//
//  Created by Abdul Diallo on 9/4/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Foundation

struct MatchViewModel {
    
    private var currentUser: User
    private var matchedUser : User
    
    var currentUserIMG : URL? {
        guard let url = URL.init(string: currentUser.images.first ?? "") else { return nil }
        return url
    }
    
    var matchedUsrImg : URL? {
        guard let url = URL.init(string: matchedUser.images.first ?? "") else { return nil }
        return url
    }
    
    var matchLabel : String {
        return "You and \(matchedUser.name) have liked each other!"
    }
    
    init(currentUser: User, matchedUser: User) {
        self.currentUser = currentUser
        self.matchedUser = matchedUser
    }
    
}
