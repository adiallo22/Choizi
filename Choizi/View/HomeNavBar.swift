//
//  HomeNavBar.swift
//  Choizi
//
//  Created by Abdul Diallo on 7/28/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

protocol NavigationDelegate : class {
    func settingTapped()
    func conversationTapped()
}

class HomeNavBar : UIStackView {
    
    weak var delegate : NavigationDelegate?
    
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
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        settingButton.addTarget(self, action: #selector(handleSetting), for: .touchUpInside)
        conversationButton.addTarget(self, action: #selector(handleConversation), for: .touchUpInside)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - helpers

extension HomeNavBar {
    fileprivate func configUI() {
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        [settingButton, UIView(), img, UIView(), conversationButton].forEach { view in
            addArrangedSubview(view)
        }
        distribution = .equalCentering
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}

//MARK: - selectors

extension HomeNavBar {
    
    @objc func handleSetting() {
        delegate?.settingTapped()
    }
    
    @objc func handleConversation() {
        delegate?.conversationTapped()
    }
    
}
