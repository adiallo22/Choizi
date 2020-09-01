//
//  MatchView.swift
//  Choizi
//
//  Created by Abdul Diallo on 9/1/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class MatchView : UIView {
    
    private let currentUser: User
    private let matchedUser: User
    
    private var matchIMG : UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "itsamatch")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private var descriptionLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private var currentUSRimg : UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "Wtfv8VY8I2RDhbQlIvSqORBAx1N2")
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    private var matchedUSERimg : UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "Wtfv8VY8I2RDhbQlIvSqORBAx1N2")
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    private var sendMSGbtn : UIButton = {
        let button = UIButton()
        button.setTitle("Send A Message", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleSendMsg), for: .touchUpInside)
        return button
    }()
    
    private var continueSwipe : UIButton = {
        let button = UIButton()
        button.setTitle("Keep Swiping", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleSwipping), for: .touchUpInside)
        return button
    }()
    
    init(currentUser: User, matchedUser: User) {
        self.currentUser = currentUser
        self.matchedUser = matchedUser
        super.init(frame: .zero)
        backgroundColor = .orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - helpers

extension MatchView {
    
    fileprivate func configUI() {
        
    }
    
}

//MARK: - selectors

extension MatchView {
    
    @objc func handleSendMsg() {
        
    }
    
    @objc func handleSwipping() {
        
    }
    
}
