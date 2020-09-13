//
//  Message.swift
//  Choizi
//
//  Created by Abdul Diallo on 9/13/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Firebase

struct Message {
    
    var content : String
    var isCurrentUser : Bool
    var user : User?
    var fromID : String
    var toID : String
    var timestamp : Timestamp
    
    init(data : [String:Any]) {
        self.content = data["content"] as? String ?? ""
        self.fromID = data["fromID"] as? String ?? ""
        self.toID = data["toID"] as? String ?? ""
        self.timestamp = data["timestamp"] as? Timestamp ?? Timestamp.init(date: Date())
        self.isCurrentUser = fromID == Auth.auth().currentUser?.uid
    }
    
}
