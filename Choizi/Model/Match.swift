//
//  Match.swift
//  Choizi
//
//  Created by Abdul Diallo on 9/5/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Foundation

struct Match {
    
    var name : String
    var uid : String
    var profileIMGurl : String
    
    init(data: [String:Any]) {
        self.name = data["name"] as? String ?? ""
        self.uid = data["uid"] as? String ?? ""
        self.profileIMGurl = data["profileIMGurl"] as? String ?? ""
    }
    
}
