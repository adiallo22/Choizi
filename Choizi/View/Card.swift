//
//  Card.swift
//  Choizi
//
//  Created by Abdul Diallo on 7/28/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class Card : UIView {
    
    private let photos : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 5
        img.layer.masksToBounds = true
        img.image = #imageLiteral(resourceName: "Wtfv8VY8I2RDhbQlIvSqORBAx1N2")
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - helpers

extension Card {
    
    func configUI() {
        addSubview(photos)
        photos.fillSuperview()
    }
    
}
