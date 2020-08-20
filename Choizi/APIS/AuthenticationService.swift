//
//  AuthenticationService.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/20/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct AuthenticationService {
    
    static func register(withCredentials credentials: UserCredential, completion: @escaping(Error?)->Void) {
        
        Service.uploadImage(image: credentials.profileIMG) { result in
            switch result {
            case .success(let imgURL):
                
                Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { authresult, err in
                    if let err = err {
                        completion(err)
                    }
                    guard let uid = authresult?.user.uid else { return }
                    let data : [String:Any] = [
                        "uid":uid,
                        "fullname":credentials.fullname,
                        "email":credentials.email,
                        "images":imgURL
                    ]
                    
                    Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
                }
            case .failure(let error):
                completion(error)
            }
        }
        
    }
    
}
