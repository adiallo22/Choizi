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
    let setting : SettingSections
    
    var placeholder : String
    var val : String? {
        switch setting {
        case .name:
            return user.name
        case .profession:
            return user.profession
        case .age:
            return "\(user.age)"
        case .bio:
            return user.bio
        case .seekingRangeAge:
            return "\(user.seekingMinAge) \(user.seekingMaxAge)"
        }
    }
    var minAgeSlider : Float {
        return Float(user.seekingMinAge)
    }
    var maxAgeSlider : Float {
        return Float(user.seekingMaxAge)
    }
    var shouldHideSlider : Bool {
        return setting != .seekingRangeAge
    }
    var shouldHideInput : Bool {
        return setting == .seekingRangeAge
    }
    
    init(user: User, setting: SettingSections) {
        self.user = user
        self.setting = setting
        self.placeholder = "Enter \(setting.description) ..."
    }
    
    func minAgeSeekingLabel(value: Float) -> String {
        return "Min: \(Int(value))"
    }
    func maxAgeSeekingLabel(value: Float) -> String {
        return "Max: \(Int(value))"
    }
    
}
