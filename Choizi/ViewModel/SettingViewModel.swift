//
//  SettingViewModel.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/22/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

enum SettingSections : Int, CaseIterable {
    
    case name
    case profession
    case age
    case bio
    case seekingRangeAge
    
    var description : String {
        switch self {
        case .name:
            return "Name"
        case .profession:
            return "Profession"
        case .age:
            return "Age"
        case .bio:
            return "Bio"
        case .seekingRangeAge:
            return "Seeking Age Range"
        }
    }
    
}

struct SettingViewModel {
    
    private let user : User
    private let setting : SettingSections
    
    var shouldHideSlider : Bool {
        return setting != .seekingRangeAge
    }
    var shouldHideInput : Bool {
        return setting == .seekingRangeAge
    }
    
    init(user: User, setting: SettingSections) {
        self.user = user
        self.setting = setting
    }
    
}
