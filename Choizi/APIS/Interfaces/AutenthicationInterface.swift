//
//  AutenthicationInterface.swift
//  Choizi
//
//  Created by Abdul Diallo on 9/22/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Firebase

protocol AuthenticationInterface {
    func register(withCredentials credentials: UserCredential, completion: @escaping(String?, Error?)->Void)
    func signIn(withEmail email: String, andPassword password: String, completion: AuthDataResultCallback?)
}
