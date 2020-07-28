//
//  HomeNavBar.swift
//  Choizi
//
//  Created by Abdul Diallo on 7/28/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class HomeNavBar : UIStackView {
    
    var settingButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "top_left_profile"), for: .normal)
        return button
    }()
    
    var conversationButton : UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "top_messages_icon"), for: .normal)
        return button
    }()
    
    var img : UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "app_icon")
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [settingButton, UIView(), img, UIView(), conversationButton].forEach { view in
            addArrangedSubview(view)
        }
        distribution = .equalCentering
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
