//
//  Card.swift
//  Choizi
//
//  Created by Abdul Diallo on 7/28/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import SDWebImage

enum SwipeDirection : Int {
    case left = -1
    case right = 1
}

class Card : UIView {
    
    private let gradient = CAGradientLayer()
    
    private let viewModel : CardViewModel
    
    private let photos : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private lazy var info : UILabel = {
        let label = UILabel()
        label.attributedText = viewModel.details
        return label
    }()
    
    private lazy var detailsButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "info_icon").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    private var barStack : UIStackView = {
        let stack = UIStackView()
        stack.spacing = 16
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    init(viewModel: CardViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
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
        photos.sd_setImage(with: viewModel.frontPhoto)
        //
        configBarStack()
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
        //
//        photos.image = viewModel.firstPhoto
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
    
    fileprivate func configBarStack() {
        (0 ..< viewModel.photos.count).forEach({ indice in
            let bar = UIView()
            bar.backgroundColor = UIColor.init(white: 0, alpha: 0.1)
            barStack.addArrangedSubview(bar)
        })
        barStack.subviews.first?.backgroundColor = .white
        addSubview(barStack)
        barStack.setDimensions(height: 4)
        barStack.anchor(top: topAnchor,
                        left: leftAnchor,
                        right: rightAnchor,
                        paddingTop: 8,
                        paddingLeft: 8,
                        paddingRight: 8)
    }
    
}

//MARK: - selectors

extension Card {
    
    @objc func handleTapGesture(_ sender: UITapGestureRecognizer) {
        let position = sender.location(in: nil).x
        let shouldShowNextPhoto = position > self.frame.width / 2
        if shouldShowNextPhoto {
            viewModel.nextPhoto()
        } else {
            viewModel.previousPhoto()
        }
        photos.sd_setImage(with: viewModel.frontPhoto)
    }
    
    @objc func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            superview?.subviews.forEach({ $0.layer.removeAllAnimations() })
        case .changed:
            swipeCard(sender)
        case .ended:
            returnCardPosition(sender)
        default:
            break
        }
    }
    
    fileprivate func swipeCard(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: nil)
        let degrees : CGFloat = translation.x / 20
        let angle = degrees * .pi / 180
        let rotation = CGAffineTransform.init(rotationAngle: angle)
        self.transform = rotation.translatedBy(x: translation.x, y: translation.y)
    }
    
    fileprivate func returnCardPosition(_ sender: UIPanGestureRecognizer) {
        let direction : SwipeDirection = sender.translation(in: nil).x > 100 ? .right : .left
        let shouldDismissCard = abs(sender.translation(in: nil).x) > 100
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            if shouldDismissCard {
                let x = CGFloat(direction.rawValue) * 1000
                let offScreen = self.transform.translatedBy(x: x, y: 0)
                self.transform = offScreen
            } else {
                self.transform = .identity
            }
        }) {_ in
            if shouldDismissCard {
                self.removeFromSuperview()
            }
        }
    }
    
}
