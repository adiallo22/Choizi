//
//  SettingHeader.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/22/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

protocol PickPhotoDelegate : class {
    func pick1stPhoto(_ header: SettingHeader)
    func pick2ndPhoto(_ header: SettingHeader)
    func pick3rdPhoto(_ header: SettingHeader)
}

class SettingHeader : UIView {
    
    weak var delegate : PickPhotoDelegate?
    
    var firstPhotoButton : UIButton = {
        let button = UIButton()
        return button
    }()
    var secondPhotoButton : UIButton = {
        let button = UIButton()
        return button
    }()
    var thirdPohotoButton : UIButton = {
        let button = UIButton()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGroupedBackground
        customizeButtons()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - helpers

extension SettingHeader {
    
    fileprivate func configUI() {
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
    
    fileprivate func customizeButtons() {
        firstPhotoButton.createPhotoButton()
        secondPhotoButton.createPhotoButton()
        thirdPohotoButton.createPhotoButton()
        //
        firstPhotoButton.addTarget(self, action: #selector(firstBtnTapped), for: .touchUpInside)
        secondPhotoButton.addTarget(self, action: #selector(secondtBtnTapped), for: .touchUpInside)
        thirdPohotoButton.addTarget(self, action: #selector(thirdBtnTapped), for: .touchUpInside)
    }
    
}

//MARK: - selectors

extension SettingHeader {
    @objc func firstBtnTapped() {
        delegate?.pick1stPhoto(self)
    }
    @objc func secondtBtnTapped() {
        delegate?.pick2ndPhoto(self)
    }
    @objc func thirdBtnTapped() {
        delegate?.pick3rdPhoto(self)
    }
}
