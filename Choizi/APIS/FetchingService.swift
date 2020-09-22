//
//  Service.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/20/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit.UIImage
import FirebaseStorage
import FirebaseAuth

let ref = Storage.storage()

protocol ServiceDownloadInterface {
    func fetchUser(withUid uid: String, completion: @escaping(Result<User, Error>)->Void)
    func fetchAllUsers(fromCurrentUser user: User, completion: @escaping(Result<[User], Error>)->Void)
    func isThereAMatch(withUser user: User, completion: @escaping(Bool)->Void)
    func fetchLikedUser(completion: @escaping([User]?) -> Void)
    func fetchMatches(completion: @escaping([Match]) -> Void)
}

protocol ServiceUploadInterface {
    func uploadImage(image: UIImage, completion: @escaping(Result<String, Error>)->Void)
    func saveData(withUser user: User, completion: @escaping(Error?)->Void)
    func saveSwipe(onUser user: User, isLike like: Bool, completion: @escaping(Error?)->Void)
    func uploadMatch(currentUser: User, matchedUser: User)
}

struct Service : ServiceDownloadInterface {
    
    func uploadImage(image: UIImage, completion: @escaping(Result<String, Error>)->Void) {
        
        guard let imgData = image.jpegData(compressionQuality: 0.7) else { return }
        let filePath = NSUUID().uuidString
        let reference = ref.reference(withPath: "/images/\(filePath)")
        
        reference.putData(imgData, metadata: nil) { data, err in
            if err != nil {
                completion(.failure(err!))
            } else {
                
                reference.downloadURL { url, err in
                    if err != nil {
                        completion(.failure(err!))
                    } else {
                        guard let imgURL = url?.absoluteString else { return }
                        completion(.success(imgURL))
                    }
                }
                
            }
        }
    }
    
}

//MARK: - Fetch User

extension Service {
    func fetchUser(withUid uid: String, completion: @escaping(Result<User, Error>)->Void) {
        collectionUserPath.document(uid).getDocument { snap, err in
            if let err = err {
                completion(.failure(err))
            } else {
                guard let value = snap?.data() else { return }
                let user = User(value: value)
                completion(.success(user))
            }
        }
    }
}

//MARK: - Fetch All Users

extension Service {
    func fetchAllUsers(fromCurrentUser user: User, completion: @escaping(Result<[User], Error>)->Void) {
        var users : [User] = []
        let query = collectionUserPath.whereField("age", isGreaterThanOrEqualTo: user.seekingMinAge)
            .whereField("age", isLessThanOrEqualTo: user.seekingMaxAge)
        Service.fetchSwipes { AlreadySwipedUsers in
            query.getDocuments { snapshot, err in
                if let err = err {
                    completion(.failure(err))
                } else {
                    snapshot?.documents.forEach({ document in
                        let value = document.data()
                        let displayUser = User.init(value: value)
                        guard displayUser.uid != Auth.auth().currentUser?.uid else { return }
                        guard AlreadySwipedUsers[displayUser.uid] == nil else { return }
                        guard displayUser.sex != user.sex else { return }
                        users.insert(displayUser, at: 0)
                    })
                    completion(.success(users))
                }
            }
        }
    }
}

//MARK: - check for matching

extension Service {
    func isThereAMatch(withUser user: User, completion: @escaping(Bool)->Void) {
        guard let currentUID = Auth.auth().currentUser?.uid else { return }
        collectionUserSwipes.document(user.uid).getDocument { snapshot, error in
            if error != nil {
                return
            } else {
                guard let data = snapshot?.data() else { return }
                guard let match = data[currentUID] as? Bool else { return }
                if match == true {
                    completion(match)
                }
            }
        }
    }
}

//MARK: - fetch swipes

extension Service {
    private static func fetchSwipes(completion: @escaping([String:Bool])->Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        collectionUserSwipes.document(uid).getDocument { snapshot, error in
            guard let data = snapshot?.data() as? [String:Bool] else {
                completion([String:Bool]())
                return
            }
            completion(data)
        }
    }
}

//MARK: - fetch liked users

extension Service {
    func fetchLikedUser(completion: @escaping([User]?) -> Void) {
        var users : [User] = []
        Service.fetchSwipes { SwipedUsers in
            SwipedUsers.forEach { key, value in
                guard value == true else { return }
                self.fetchUser(withUid: key) { result in
                    switch result {
                    case .success(let user):
                        users.append(user)
                    case .failure(_):
                        completion(nil)
                    }
                }
                completion(users)
            }
        }
    }
}


//MARK: - fetch matches

extension Service {
    func fetchMatches(completion: @escaping([Match]) -> Void) {
        var matches : [Match] = []
        guard let uid = Auth.auth().currentUser?.uid else { return }
        collectionMatchesMsg.document(uid).collection("matches").getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            matches = documents.map({ Match.init(data: $0.data()) })
            completion(matches)
        }
    }
}
