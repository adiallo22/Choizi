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
    static func fetchAllUsers(completion: @escaping(Result<[User], Error>)->Void) {
        var users : [User] = []
        collectionUserPath.getDocuments { snapshot, err in
            if let err = err {
                completion(.failure(err))
            } else {
                snapshot?.documents.forEach({ document in
                    let value = document.data()
                    let user = User.init(value: value)
                    users.insert(user, at: 0)
                })
                completion(.success(users))
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
