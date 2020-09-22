//
//  ServiceInterface.swift
//  Choizi
//
//  Created by Abdul Diallo on 9/22/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

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
