//
//  DownloadServiceMock.swift
//  ChoiziTests
//
//  Created by Abdul Diallo on 9/24/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
@testable import Choizi

enum FetchingErrors : Error {
    
    case fetchUserError
    case fetchUsersError
    case isThereAMatchError
    case fetchLikedUserError
    case fetchMatchesError
    
    var description : String {
        switch self {
        case .fetchUserError : return "Error fetching user"
        case .fetchUsersError : return "Error fetching users"
        case .isThereAMatchError : return "Error fetching match"
        case .fetchLikedUserError : return "Error fetching liked user"
        case .fetchMatchesError : return "Error fetching matched users"
        }
    }
    
}

class DownloadServiceMock : ServiceDownloadInterface {
    
    var fetchUserIsCalled : Bool = false
    var fetchAllUsersIsCalled : Bool = false
    var isThereAMatchCalled : Bool = false
    var fetchLikedUserCalled : Bool = false
    var fetchMatchesIsCalled : Bool = false
    var shouldReturnError : Bool = false
    
    let mockUser : User = User(value: ["name":"abdul", "age":"23"])
    let mockUsers : [User] = [mockUser, mockUser]
    let mockMatch : Match = Match(data: ["test":"test"])
    let mockMatches : [Match] = [mockMatch, mockMatch]
    
    init(_ shouldReturnError : Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    convenience init () {
        super.init(false)
    }
    
}

//MARK: - <#section heading#>

extension DownloadServiceMock {
    
    func fetchUser(withUid uid: String, completion: @escaping(Result<User, FetchingErrors>)->Void) {
        if shouldReturnError {
            completion(.failure(.fetchUserError))
        } else {
            completion(mockUser)
        }
    }
    
    func fetchAllUsers(fromCurrentUser user: User, completion: @escaping(Result<[User], Error>)->Void) {
        if shouldReturnError {
            completion(.failure(.fetchAllUsersError))
        } else {
            completion(mockUsers)
        }
    }
    
    func isThereAMatch(withUser user: User, completion: @escaping(Bool)->Void) {
        if shouldReturnError {
            completion(.isThereAMatchError)
        } else {
            completion(true)
        }
    }
    
    func fetchLikedUser(completion: @escaping([User]?) -> Void) {
        if shouldReturnError {
            completion(FetchingErrors.fetchLikedUserError)
        } else {
            completion(mockUsers)
        }
    }
    
    func fetchMatches(completion: @escaping([Match]) -> Void) {
        if shouldReturnError {
            completion(FetchingErrors.fetchMatchesError)
        } else {
            completion(mockMatches)
        }
    }
    
}

