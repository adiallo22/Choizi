//
//  MessageService.swift
//  Choizi
//
//  Created by Abdul Diallo on 9/13/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Firebase

struct MessageService {
    
    static let shared = MessageService()
    
    //MARK: - upload message
    
    func uploadMessage(_ message: String, to user : User, completion: ((Error?) -> Void)?) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let data = [
            "content":message,
//            "isCurrentUser":true,
            "timestamp":Timestamp.init(date: Date()),
            "fromID":uid,
            "toID":user.uid,
        ] as [String:Any]
        collectionMatchesMsg.document(uid).collection(user.uid).addDocument(data: data) { _ in
            collectionMatchesMsg.document(user.uid).collection(uid).addDocument(data: data, completion: completion)
        }
    }
    
}
