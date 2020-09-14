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
            "timestamp":Timestamp.init(date: Date()),
            "fromID":uid,
            "toID":user.uid,
        ] as [String:Any]
        collectionMatchesMsg.document(uid).collection(user.uid).addDocument(data: data) { _ in
            collectionMatchesMsg.document(user.uid).collection(uid).addDocument(data: data, completion: completion)
            //
            collectionMatchesMsg.document(uid).collection("recent_messages").document(user.uid).setData(data)
            collectionMatchesMsg.document(user.uid).collection("recent_messages").document(uid).setData(data)
        }
    }
    
}

//MARK: - fetch Messages with a specific user

extension MessageService {
    func fetchMessage(for user: User, completion: @escaping(Result<[Message], Error>) -> Void) {
        var messages : [Message] = []
        guard let currentUID =  Auth.auth().currentUser?.uid else { return }
        let query = collectionMatchesMsg.document(currentUID).collection(user.uid).order(by: "timestamp")
        query.addSnapshotListener { snapshot, error in
            if let error = error {
                completion(.failure(error))
            } else {
                snapshot?.documentChanges.forEach({ change in
                    if change.type == .added {
                        let data = change.document.data()
                        messages.append(Message.init(data: data))
                    }
                    completion(.success(messages))
                })
            }
        }
    }
}

//MARK: - fetch conversations

extension MessageService {
    func fetchConversations(completion: @escaping(Result<[ConversationModel], Error>) -> Void) {
        var conversations : [ConversationModel] = []
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let query  = collectionMatchesMsg.document(uid).collection("recent_messages").order(by: "timestamp")
        query.addSnapshotListener { snapshot, error in
            if let error = error {
                completion(.failure(error))
            } else {
                snapshot?.documentChanges.forEach({ change in
                    let data = change.document.data()
                    let msg = Message.init(data: data)
                    Service.fetchUser(withUid: msg.fromID) { result in
                        switch result {
                        case .success(let user):
                            conversations.append(ConversationModel.init(user: user, message: msg))
                            completion(.success(conversations))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                })
            }
        }
    }
}
