//
//  FooterHomeBar.swift
//  Choizi
//
//  Created by Abdul Diallo on 7/28/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class FooterHomeBar : UIStackView {
    
    var refreshBtn : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "refresh_circle"), for: .normal)
        return button
    }()
    var dislikeBtn : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "dismiss_circle"), for: .normal)
        return button
    }()
    var superLikeBtn : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "super_like_circle"), for: .normal)
        return button
    }()
    var likeBtn : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "like_circle"), for: .normal)
        return button
    }()
    var boostBtn : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "boost_circle"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        [refreshBtn, dislikeBtn, superLikeBtn, likeBtn, boostBtn].forEach { view in
            addArrangedSubview(view)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
