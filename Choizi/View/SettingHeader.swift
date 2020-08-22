//
//  SettingHeader.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/22/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class SettingHeader : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - helpers

extension SettingHeader {
    
    fileprivate func configUI() {
        let firstPhotoButton = createPhotoBuntton()
        let secondPhotoButton = createPhotoBuntton()
        let thirdPohotoButton = createPhotoBuntton()
        //
        addSubview(firstPhotoButton)
        firstPhotoButton.anchor(top: topAnchor,
                                left: leftAnchor,
                                bottom: bottomAnchor,
                                paddingTop: 16,
                                paddingLeft: 16,
                                paddingBottom: 16)
        firstPhotoButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45).isActive = true
        //
        let stack : UIStackView = {
            let stack = UIStackView.init(arrangedSubviews: [secondPhotoButton, thirdPohotoButton])
            stack.spacing = 16
            stack.axis = .vertical
            stack.distribution = .fillEqually
            return stack
        }()
        addSubview(stack)
        stack.anchor(top: topAnchor,
                     left: firstPhotoButton.rightAnchor,
                     bottom: bottomAnchor,
                     right: rightAnchor,
                     paddingTop: 16,
                     paddingLeft: 16,
                     paddingBottom: 16,
                     paddingRight: 16)
    }
    
    fileprivate func createPhotoBuntton() -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleTapped), for: .touchUpInside)
        button.backgroundColor = .white
        return button
    }
    
}

//MARK: - selectors

extension SettingHeader {
    @objc func handleTapped() {
        print("tapped..")
    }
}
