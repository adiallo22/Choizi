//
//  CAonversationViewModel.swift
//  Choizi
//
//  Created by Abdul Diallo on 9/13/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Foundation

struct ConversationViewModel {
    
    private var conversation : ConversationModel
    
    var profileIMG : URL? {
        guard let link = conversation.user.images.first else { return nil }
        return URL.init(string: link) ?? nil
    }
    
    var content : String {
        return conversation.message.content
    }
    
    var username : String? {
        return conversation.user.name
    }
    
    var timestamp : String {
        let date = conversation.message.timestamp.dateValue()
        let formater = DateFormatter()
        formater.dateFormat = "hh:mm a"
        return formater.string(from: date)
    }
    
    init(conversation : ConversationModel) {
        self.conversation = conversation
    }
    
}
