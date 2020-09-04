//
//  ConversationHeader.swift
//  Choizi
//
//  Created by Abdul Diallo on 9/4/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class ConversationHeader : UIView {
    
    private var label : UILabel = {
        let label = UILabel()
        label.text = "New Matches"
        label.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.anchor(top: topAnchor,
                     left: leftAnchor,
                     paddingTop: 8,
                     paddingLeft: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
