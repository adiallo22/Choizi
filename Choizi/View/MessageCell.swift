//
//  MessageCell.swift
//  Choizi
//
//  Created by Abdul Diallo on 9/12/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class MessageCell : UICollectionViewCell {
    
    var message : Message? {
        didSet { configViewModel() }
    }
    
    var bubbleLeftAnchor : NSLayoutConstraint!
    var bubbleRightAnchor : NSLayoutConstraint!
    
    var userIMG : UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    var messageContent : UITextView = {
        let view = UITextView()
        view.backgroundColor = .clear
        view.font = UIFont.systemFont(ofSize: 16)
        view.isScrollEnabled = false
        view.isEditable = false
        return view
    }()
    
    private var bubble : UIView = {
        let view = UIView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - helpers

extension MessageCell {
    
    fileprivate func configUI() {
        addSubview(userIMG)
        userIMG.anchor(left: leftAnchor,
                       bottom: bottomAnchor,
                       paddingLeft: 8,
                       paddingBottom: 2)
        userIMG.setDimensions(height: 32, width: 32)
        userIMG.layer.cornerRadius = 32 / 2
        //
        addSubview(bubble)
        bubble.anchor(top: topAnchor)
        bubbleLeftAnchor = bubble.leftAnchor.constraint(equalTo: userIMG.rightAnchor, constant: 8)
        bubbleLeftAnchor.isActive = false
        bubbleRightAnchor = bubble.rightAnchor.constraint(equalTo: rightAnchor, constant: -8)
        bubbleRightAnchor.isActive = false
        bubble.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        bubble.layer.cornerRadius = 12
        //
        bubble.addSubview(messageContent)
        messageContent.anchor(top: bubble.topAnchor,
                              left: bubble.leftAnchor,
                              bottom: bubble.bottomAnchor,
                              right: bubble.rightAnchor,
                              paddingTop: 4,
                              paddingLeft: 12,
                              paddingBottom: 4,
                              paddingRight: 12)
    }
    
    fileprivate func configViewModel() {
        guard let message = message else { return }
        let viewModel = MessageViewModel.init(message: message)
        bubble.backgroundColor = viewModel.bubbleBackgroundColor
        messageContent.textColor = viewModel.messageTextColor
        messageContent.text = viewModel.content
        bubbleLeftAnchor.isActive = viewModel.leftAnchorActive
        bubbleRightAnchor.isActive = viewModel.rightAnchorActive
        userIMG.isHidden = viewModel.showUserImage
        userIMG.sd_setImage(with: viewModel.userProfile)
    }
    
}
