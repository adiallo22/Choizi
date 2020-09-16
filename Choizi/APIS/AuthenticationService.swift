//
//  AuthenticationService.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/20/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import FirebaseAuth
import FirebaseFirestore

struct AuthenticationService {
    
    static func register(withCredentials credentials: UserCredential, completion: @escaping(String?, Error?)->Void) {
        
        Service.uploadImage(image: credentials.profileIMG) { result in
            switch result {
            case .success(let imgURL):
                
                Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { authresult, err in
                    if let err = err {
                        completion(nil, err)
                    }
                    guard let uid = authresult?.user.uid else { return }
                    let data : [String:Any] = [
                        "uid":uid,
                        "fullname":credentials.fullname,
                        "email":credentials.email,
                        "images":[imgURL],
                        "age":credentials.age,
                        "sex":credentials.sex
                    ]
                    
                    Firestore.firestore().collection("users").document(uid).setData(data) { error in
                        completion(uid, error)
                    }
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
        
    }
    
}

//MARK: - LOGGIN

extension AuthenticationService {
    static func signIn(withEmail email: String,
                       andPassword password: String,
                       completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
}
