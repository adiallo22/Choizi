//
//  MatchView.swift
//  Choizi
//
//  Created by Abdul Diallo on 9/1/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class MatchView : UIView {
    
    private let currentUser: User
    private let matchedUser: User
    
    private var matchIMG : UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "itsamatch")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private var descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "You and a User has liked each other!"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private var currentUSRimg : UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "Wtfv8VY8I2RDhbQlIvSqORBAx1N2")
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    private var matchedUSERimg : UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "Wtfv8VY8I2RDhbQlIvSqORBAx1N2")
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    private var sendMSGbtn : UIButton = {
        let button = UIButton()
        button.setTitle("Send A Message", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleSendMsg), for: .touchUpInside)
        return button
    }()
    
    private var continueSwipe : UIButton = {
        let button = UIButton()
        button.setTitle("Keep Swiping", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleSwipping), for: .touchUpInside)
        return button
    }()
    
    let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
//    private lazy var views = [MatchView]
    
    init(currentUser: User, matchedUser: User) {
        self.currentUser = currentUser
        self.matchedUser = matchedUser
        super.init(frame: .zero)
        configBackground()
        configUI()
        configAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - helpers

extension MatchView {
    
    fileprivate func configUI() {
        addSubview(currentUSRimg)
        currentUSRimg.anchor(left: centerXAnchor, paddingLeft: 16)
        currentUSRimg.setDimensions(height: 140, width: 140)
        currentUSRimg.layer.cornerRadius = 70
        currentUSRimg.centerY(inView: self)
        //
        addSubview(matchedUSERimg)
        matchedUSERimg.anchor(right: centerXAnchor, paddingRight: 16)
        matchedUSERimg.setDimensions(height: 140, width: 140)
        matchedUSERimg.layer.cornerRadius = 70
        matchedUSERimg.centerY(inView: self)
        //
        addSubview(sendMSGbtn)
        sendMSGbtn.anchor(top: matchedUSERimg.bottomAnchor,
                          left: leftAnchor,
                          right: rightAnchor,
                          paddingTop: 48,
                          paddingLeft: 48,
                          paddingRight: 48)
        sendMSGbtn.setDimensions(height: 50)
        //
        addSubview(continueSwipe)
        continueSwipe.anchor(top: sendMSGbtn.bottomAnchor,
                          left: leftAnchor,
                          right: rightAnchor,
                          paddingTop: 16,
                          paddingLeft: 48,
                          paddingRight: 48)
        continueSwipe.setDimensions(height: 50)
        //
        addSubview(descriptionLabel)
        descriptionLabel.anchor(left: leftAnchor,
                                bottom: currentUSRimg.topAnchor,
                                right: rightAnchor,
                                paddingLeft: 48,
                                paddingBottom: 48,
                                paddingRight: 48)
        descriptionLabel.setDimensions(height: 50)
        //
        addSubview(matchIMG)
        matchIMG.anchor(left: leftAnchor,
                                bottom: descriptionLabel.topAnchor,
                                right: rightAnchor,
                                paddingLeft: 48,
                                paddingBottom: 16,
                                paddingRight: 48)
        matchIMG.setDimensions(height: 50)
        configButtons()
    }
    
    fileprivate func configBackground() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismiss))
        blurView.addGestureRecognizer(tap)
        addSubview(blurView)
        blurView.fillSuperview()
        blurView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
                        self.blurView.alpha = 1
        }, completion: nil)
    }
    
    fileprivate func configButtons() {
        sendMSGbtn.layer.cornerRadius = 25
        sendMSGbtn.layer.borderWidth = 2
        sendMSGbtn.layer.masksToBounds = true
        sendMSGbtn.layer.borderColor = UIColor.white.cgColor
        //
        continueSwipe.layer.cornerRadius = 25
        continueSwipe.layer.borderColor = UIColor.white.cgColor
        continueSwipe.layer.borderWidth = 2
    }
    
    fileprivate func configAnimation() {
        let angle = 30 * CGFloat.pi / 180
        currentUSRimg.transform = CGAffineTransform(rotationAngle: angle).concatenating(CGAffineTransform(translationX: -200, y: 0))
        matchedUSERimg.transform = CGAffineTransform(rotationAngle: -angle).concatenating(CGAffineTransform(translationX: 200, y: 0))
        //
        sendMSGbtn.transform = CGAffineTransform(translationX: -500, y: 0)
        continueSwipe.transform = CGAffineTransform(translationX: 500, y: 0)
        //
        UIView.animateKeyframes(withDuration: 1.3, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.45) {
                self.currentUSRimg.transform = CGAffineTransform(rotationAngle: -angle)
                self.matchedUSERimg.transform = CGAffineTransform(rotationAngle: -angle)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4) {
                self.currentUSRimg.transform = .identity
                self.matchedUSERimg.transform = .identity
            }
        },
        completion: nil)
        //
        UIView.animate(withDuration: 0.75, delay: 1.3 * 0.6, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            self.sendMSGbtn.transform = .identity
            self.continueSwipe.transform = .identity
        },
        completion: nil)
    }
    
}

//MARK: - selectors

extension MatchView {
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
                        self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
    @objc func handleSendMsg() {
        print("send message")
    }
    
    @objc func handleSwipping() {
        print("keep swipping")
    }
    
}
