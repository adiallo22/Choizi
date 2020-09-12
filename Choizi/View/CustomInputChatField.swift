//
//  CustomInputChatField.swift
//  Choizi
//
//  Created by Abdul Diallo on 9/12/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class CustomInputChatField : UIView {
    
    var inputTextField : UITextView = {
        let tf = UITextView()
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.isScrollEnabled = false
        return tf
    }()
    
    private lazy var sendButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoresizingMask = .flexibleHeight
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //populate the view size depending on its properties size
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
}

//MARK: - helpers

extension CustomInputChatField {
    fileprivate func configUI() {
        addSubview(sendButton)
        sendButton.anchor(top: topAnchor,
                          right: rightAnchor,
                          paddingTop: 4,
                          paddingRight: 8)
        sendButton.setDimensions(height: 50, width: 50)
        inputTextField.anchor(top: topAnchor,
                              left: leftAnchor,
                              bottom: safeAreaLayoutGuide.bottomAnchor,
                              right: sendButton.leftAnchor,
                              paddingTop: 4,
                              paddingLeft: 8,
                              paddingBottom: 4,
                              paddingRight: 8)
    }
}

//MARK: - selectors

extension CustomInputChatField {
    @objc func handleSendMessage() {
        print("\(inputTextField.text) message is isent")
    }
}
