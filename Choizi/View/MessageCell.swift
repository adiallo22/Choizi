//
//  MessageCell.swift
//  Choizi
//
//  Created by Abdul Diallo on 9/12/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class MessageCell : UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
