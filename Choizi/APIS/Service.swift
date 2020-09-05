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

struct Service {
    
    static func uploadImage(image: UIImage, completion: @escaping(Result<String, Error>)->Void) {
        
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
    static func fetchUser(withUid uid: String, completion: @escaping(Result<User, Error>)->Void) {
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
    static func fetchAllUsers(fromCurrentUser user: User, completion: @escaping(Result<[User], Error>)->Void) {
        var users : [User] = []
        let query = collectionUserPath.whereField("age", isGreaterThanOrEqualTo: user.seekingMinAge)
            .whereField("age", isLessThanOrEqualTo: user.seekingMaxAge)
        fetchSwipes { AlreadySwipedUsers in
            query.getDocuments { snapshot, err in
                if let err = err {
                    completion(.failure(err))
                } else {
                    snapshot?.documents.forEach({ document in
                        let value = document.data()
                        let user = User.init(value: value)
                        guard user.uid != Auth.auth().currentUser?.uid else { return }
                        guard AlreadySwipedUsers[user.uid] == nil else { return }
                        users.insert(user, at: 0)
                    })
                    completion(.success(users))
                }
            }
        }
    }
}

//MARK: - Upload data

extension Service {
    static func saveData(withUser user: User, completion: @escaping(Error?)->Void) {
        let data : [String:Any] = [
            "uid":user.uid,
            "fullname":user.name,
            "email":user.email,
            "age":user.age,
            "images":user.images,
            "bio":user.bio,
            "profession":user.profession,
            "seekingMinAge":user.seekingMinAge,
            "seekingMaxAge":user.seekingMaxAge
        ]
        collectionUserPath.document(user.uid).setData(data, completion: completion)
    }
}

//MARK: - save swipes

extension Service {
    static func saveSwipe(onUser user: User, isLike like: Bool, completion: @escaping(Error?)->Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        collectionUserSwipes.document(uid).getDocument { snapshot, error in
            if let error = error {
                completion(error)
            } else {
                let data = [user.uid:like]
                if snapshot?.exists == true {
                    collectionUserSwipes.document(uid).updateData(data)
                } else {
                    collectionUserSwipes.document(uid).setData(data)
                }
            }
        }
    }
}

//MARK: - check for matching

extension Service {
    static func isThereAMatch(withUser user: User, completion: @escaping(Bool)->Void) {
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
    static func fetchLikedUser(completion: @escaping([User]?) -> Void) {
        var users : [User] = []
        fetchSwipes { SwipedUsers in
            SwipedUsers.forEach { key, value in
                guard value == true else { return }
                fetchUser(withUid: key) { result in
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

//MARK: - upload matches

extension Service {
    static func uploadMatch(currentUser: User, matchedUser: User) {
        guard let matchedURL = matchedUser.images.first else { return }
        guard let currentUSRurl = currentUser.images.first else { return }
        //upload match from current user standpoint
        let matchUsrData = [
            "name":matchedUser.name,
            "uid":matchedUser.uid,
            "profileIMGurl":matchedURL
        ]
        collectionMatchesMsg.document(currentUser.uid).collection("matches").document(matchedUser.uid).setData(matchUsrData)
        //upload match from matched user standpoint
        let currentUsrData = [
            "name":currentUser.name,
            "uid":currentUser.uid,
            "profileIMGurl":currentUSRurl
        ]
        collectionMatchesMsg.document(matchedUser.uid).collection("matches").document(currentUser.uid).setData(currentUsrData)
    }
}
