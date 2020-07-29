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
        button.setImage(#imageLiteral(resourceName: "flag"), for: .normal)
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
        [refreshBtn, dislikeBtn, superLikeBtn, likeBtn, boostBtn].forEach { view in
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
