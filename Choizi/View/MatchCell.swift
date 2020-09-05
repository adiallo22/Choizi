//
//  MatchCell.swift
//  Choizi
//
//  Created by Abdul Diallo on 9/5/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import SDWebImage

class MatchCell : UICollectionViewCell {
    
    var matchViewModel : MatchCellViewModel? {
        didSet { configData() }
    }
    
    private let profileIMG : UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.white.cgColor
        view.setDimensions(height: 80, width: 80)
        view.layer.cornerRadius = 40
        return view
    }()
    
    private let label : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 2
        return label
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

extension MatchCell {
    
    fileprivate func configUI() {
        let stack : UIStackView = {
            let stack = UIStackView.init(arrangedSubviews: [profileIMG, label])
            stack.alignment = .center
            stack.distribution = .fillProportionally
            stack.axis = .vertical
            stack.spacing = 6
            return stack
        }()
        addSubview(stack)
        stack.fillSuperview()
    }
    
    fileprivate func configData() {
        guard let matchVM = matchViewModel else { return }
        profileIMG.sd_setImage(with: matchVM.imageURL)
        label.text = matchVM.name
    }
}
