//
//  FooterHomeBar.swift
//  Choizi
//
//  Created by Abdul Diallo on 7/28/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

protocol FooterHomeBarDelegate : class {
    func handleSuperLike()
    func handleLike()
    func handleDisLike()
    func handleBoost()
    func handleRefresh()
}

class FooterHomeBar : UIStackView {
    
    weak var delegate : FooterHomeBarDelegate?
    
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
        configUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - helpers

extension FooterHomeBar {
    fileprivate func configUI() {
        setDimensions(height: 100)
        [refreshBtn, dislikeBtn, superLikeBtn, likeBtn, boostBtn].forEach { view in
            addArrangedSubview(view)
        }
        refreshBtn.addTarget(self, action: #selector(handleRefresh), for: .touchUpInside)
        superLikeBtn.addTarget(self, action: #selector(handleSuperlike), for: .touchUpInside)
        dislikeBtn.addTarget(self, action: #selector(handleDislike), for: .touchUpInside)
        likeBtn.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        boostBtn.addTarget(self, action: #selector(handleBoost), for: .touchUpInside)
    }
}

//MARK: - selectors

extension FooterHomeBar {
    @objc func handleRefresh() {
        delegate?.handleRefresh()
    }
    @objc func handleSuperlike() {
        delegate?.handleSuperLike()
    }
    @objc func handleLike() {
        delegate?.handleLike()
    }
    @objc func handleDislike() {
        delegate?.handleDisLike()
    }
    @objc func handleBoost() {
        delegate?.handleBoost()
    }
}
