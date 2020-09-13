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
        return message.isCurrentUser ? .lightGray : .systemBlue
    }
    
    var messageTextColor : UIColor {
        return message.isCurrentUser ? .white : .lightGray
    }
    
    var content : String {
        return message.content
    }
    
    init(message: Message) {
        self.message = message
    }
    
}
