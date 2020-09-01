//
//  MatchView.swift
//  Choizi
//
//  Created by Abdul Diallo on 9/1/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class MatchView : UIView {
    
    private let currentUser: User
    private let matchedUser: User
    
    init(currentUser: User, matchedUser: User) {
        self.currentUser = currentUser
        self.matchedUser = matchedUser
        super.init(frame: .zero)
        backgroundColor = .orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
