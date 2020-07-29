//
//  Card.swift
//  Choizi
//
//  Created by Abdul Diallo on 7/28/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class Card : UIView {
    
    private let gradient = CAGradientLayer()
    
    private let photos : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.image = #imageLiteral(resourceName: "Wtfv8VY8I2RDhbQlIvSqORBAx1N2")
        return img
    }()
    
    private var info : UILabel = {
        let label = UILabel()
        let attributed = NSMutableAttributedString(string: "Dylan Amadou", attributes: [
                                                    .font: UIFont.systemFont(ofSize: 30, weight: .heavy),
                                                    .foregroundColor: UIColor.white])
        attributed.append(NSAttributedString.init(string: "  0",
                                                  attributes: [
                                                    .font: UIFont.systemFont(ofSize: 22),
                                                    .foregroundColor : UIColor.white]))
        label.attributedText = attributed
        return label
    }()
    
    private lazy var detailsButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "info_icon").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        configGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        gradient.frame = self.frame
    }
    
}

//MARK: - helpers

extension Card {
    
    fileprivate func configUI() {
        layer.cornerRadius = 5
        clipsToBounds = true
        addSubview(photos)
        photos.fillSuperview()
        //
        gradientBottom()
        //
        addSubview(info)
        info.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
        //
        addSubview(detailsButton)
        detailsButton.anchor(right: rightAnchor, paddingRight: 16)
        detailsButton.centerY(inView: info)
        detailsButton.setDimensions(height: 40, width: 40)
    }
    
    fileprivate func gradientBottom() {
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.4, 1.0]
        layer.addSublayer(gradient)
    }
    
    fileprivate func configGestures() {
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(handleTapGesture))
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(handlePanGesture))
        addGestureRecognizer(tap)
        addGestureRecognizer(pan)
    }
    
}

//MARK: - selectors

extension Card {
    
    @objc func handleTapGesture(withSender sender: UITapGestureRecognizer) {
        print("tapped")
    }
    
    @objc func handlePanGesture(withSender sender: UIPanGestureRecognizer) {
        print("paned")
    }
    
}
