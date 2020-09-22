//
//  UploadingService.swift
//  Choizi
//
//  Created by Abdul Diallo on 9/22/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import Firebase

//MARK: - upload matches

extension Service {
    func uploadMatch(currentUser: User, matchedUser: User) {
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

//MARK: - save swipes

extension Service {
    func saveSwipe(onUser user: User, isLike like: Bool, completion: @escaping(Error?)->Void) {
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

//MARK: - Upload data

extension Service {
    func saveData(withUser user: User, completion: @escaping(Error?)->Void) {
        let data : [String:Any] = [
            "uid":user.uid,
            "fullname":user.name,
            "email":user.email,
            "age":user.age,
            "sex":user.sex,
            "images":user.images,
            "bio":user.bio,
            "profession":user.profession,
            "seekingMinAge":user.seekingMinAge,
            "seekingMaxAge":user.seekingMaxAge
        ]
        collectionUserPath.document(user.uid).setData(data, completion: completion)
    }
}




