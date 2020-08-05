//
//  AuthViewModel.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/5/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Foundation

//MARK: - LoginViewModel

struct LoginViewModel {
    
    var email : String
    var password : String
    
    var isValid : Bool {
        return !email.isEmpty && !password.isEmpty
    }
    
}

//MARK: - SignUpViewModel

struct SignUpViewModel {
    
    var email : String
    var password : String
    var fullname : String
    
    var isValid : Bool {
        return !email.isEmpty && !password.isEmpty && !fullname.isEmpty
    }
    
}
