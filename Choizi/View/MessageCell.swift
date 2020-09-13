//
//  MessageCell.swift
//  Choizi
//
//  Created by Abdul Diallo on 9/12/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class MessageCell : UICollectionViewCell {
    
    private var userIMG : UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private var messageContent : UITextView = {
        let view = UITextView()
        view.backgroundColor = .clear
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 16)
        view.isScrollEnabled = false
        view.isEditable = false
        return view
    }()
    
    private var bubble : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
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
        bubble.anchor(top: topAnchor,
                      left: userIMG.rightAnchor,
                      paddingLeft: 8)
        bubble.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        bubble.layer.cornerRadius = 12
        bubble.layer.masksToBounds = true
        //
        addSubview(messageContent)
        messageContent.anchor(top: bubble.topAnchor,
                              left: bubble.leftAnchor,
                              bottom: bubble.bottomAnchor,
                              right: bubble.rightAnchor,
                              paddingTop: 4,
                              paddingLeft: 12,
                              paddingBottom: 4,
                              paddingRight: 12)
    }
    
}
