//
//  SettingHeader.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/22/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import SDWebImage

protocol PickPhotoDelegate : class {
    func pick1stPhoto(_ header: SettingHeader)
    func pick2ndPhoto(_ header: SettingHeader)
    func pick3rdPhoto(_ header: SettingHeader)
}

class SettingHeader : UIView {
    
    weak var delegate : PickPhotoDelegate?
    
    private var user : User
    
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
//    private lazy var buttons = [firstPhotoButton, secondPhotoButton, thirdPohotoButton]
    
    init(user: User) {
        self.user = user
        super.init(frame: .zero)
        backgroundColor = .systemGroupedBackground
        customizeButtons()
        configUI()
        loadImages()
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
    
    fileprivate func loadImages() {
        let URLs = user.images.map({ URL.init(string: $0) })
        for (index, value) in URLs.enumerated() {
            SDWebImageManager.shared.loadImage(with: value, options: .continueInBackground, progress: nil) { (image, _, _, _, _, _) in
                if index == 0 {
                    self.firstPhotoButton.setImage(image, for: .normal)
                } else if index == 1 {
                    self.secondPhotoButton.setImage(image, for: .normal)
                } else {
                    self.thirdPohotoButton.setImage(image, for: .normal)
                }
            }
        }
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
