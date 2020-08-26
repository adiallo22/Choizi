//
//  ProfileCell.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/26/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class ProfileCell : UICollectionViewCell {
    
    var userIMG : UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
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

extension ProfileCell {
    fileprivate func configUI() {
        addSubview(userIMG)
        userIMG.fillSuperview()
    }
}
