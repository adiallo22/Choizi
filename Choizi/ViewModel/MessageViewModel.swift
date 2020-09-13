//
//  MessageViewModel.swift
//  Choizi
//
//  Created by Abdul Diallo on 9/13/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

struct MessageViewModel {
    
    private let message : Message
    
    var bubbleBackgroundColor : UIColor {
        return message.isCurrentUser ? .systemBlue : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    
    var messageTextColor : UIColor {
        return message.isCurrentUser ? .white : .black
    }
    
    var content : String {
        return message.content
    }
    
    var rightAnchorActive : Bool {
        return message.isCurrentUser
    }
    
    var leftAnchorActive : Bool {
        return !message.isCurrentUser
    }
    
    var showUserImage : Bool {
        return message.isCurrentUser
    }
    
    init(message: Message) {
        self.message = message
    }
    
}
