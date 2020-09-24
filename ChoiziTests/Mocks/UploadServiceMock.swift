//
//  UploadServiceMock.swift
//  ChoiziTests
//
//  Created by Abdul Diallo on 9/23/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
@testable import Choizi

class UploadServiceMock : ServiceUploadInterface {
    
    var shouldReturnError = false
    var uploadIMGCalled = false
    var saveDataCalled = false
    var saveSwipeCalled = false
    var uploadMatchCalled = false
    
    init(_ shouldReturnError : Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    convenience init () {
        super.init(false)
    }
    
}

//MARK: - <#section heading#>

extension UploadServiceMock {
    func uploadImage(image: UIImage, completion: @escaping(Result<String, Error>)->Void) {
        uploadIMGCalled = true
        if shouldReturnError {
            completion(.failure(Error()))
        } else {
            completion(.success("image successfully uploaded"))
        }
    }
    
    func saveData(withUser user: User, completion: @escaping(Error?)->Void) {
        saveDataCalled = true
        if shouldReturnError {
            completion(Error())
        }
    }
    
    func saveSwipe(onUser user: User, isLike like: Bool, completion: @escaping(Error?)->Void) {
        saveSwipeCalled = true
        if shouldReturnError {
            completion(Error())
        }
    }
    
    func uploadMatch(currentUser: User, matchedUser: User) {
        
    }
}
