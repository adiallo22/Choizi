//
//  MatchCellViewModel.swift
//  Choizi
//
//  Created by Abdul Diallo on 9/5/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Foundation

struct MatchCellViewModel {
    
    private var match : Match
    
    var imageURL : URL? {
        guard let url = URL.init(string: match.profileIMGurl) else { return nil }
        return url
    }
    
    var name : String {
        return match.name
    }
    
    var uid : String {
        return match.uid
    }
    
    init(match: Match) {
        self.match = match
    }
    
}
