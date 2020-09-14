//
//  ConversationCell.swift
//  Choizi
//
//  Created by Abdul Diallo on 9/13/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class ConversationCell : UITableViewCell {
    
    var conversation : ConversationModel? {
        didSet { configViewModel() }
    }
    
    private var profileIMG : UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .lightGray
        return view
    }()
    
    private var timestamp : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkGray
        label.text = "1h"
        return label
    }()
    
    private var username : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private var message : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - helpers

extension ConversationCell {
    
    fileprivate func configUI() {
        addSubview(profileIMG)
        profileIMG.setDimensions(height: 50, width: 50)
        profileIMG.layer.cornerRadius = 25
        profileIMG.anchor(left: leftAnchor, paddingLeft: 12)
        profileIMG.centerY(inView: self)
        //
        let stack : UIStackView = {
            let stack = UIStackView.init(arrangedSubviews: [username, message])
            stack.spacing = 4
            stack.axis = .vertical
            return stack
        }()
        addSubview(stack)
        stack.centerY(inView: self)
        stack.anchor(left: profileIMG.rightAnchor,
                     right: rightAnchor,
                     paddingLeft: 12,
                     paddingRight: 16)
        //
        addSubview(timestamp)
        timestamp.anchor(top: topAnchor,
                         right: rightAnchor,
                         paddingTop: 20,
                         paddingRight: 12)
    }
    
    fileprivate func configViewModel() {
        
    }
    
}
