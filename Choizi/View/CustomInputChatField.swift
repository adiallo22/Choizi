//
//  CustomInputChatField.swift
//  Choizi
//
//  Created by Abdul Diallo on 9/12/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

protocol CustomInputChatFieldDelegate : class {
    func handleSendMessage(_ view: CustomInputChatField, withMessage message: String)
}

class CustomInputChatField : UIView {
    
    weak var delegate : CustomInputChatFieldDelegate?
    
    private var inputTextField : UITextView = {
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
    
    private var placeholder: UILabel = {
        let placeholder = UILabel()
        placeholder.text = "Type your message here.."
        placeholder.font = UIFont.systemFont(ofSize: 16)
        placeholder.textColor = .lightGray
        return placeholder
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoresizingMask = .flexibleHeight
        backgroundColor = .white
        configUI()
        addShadowOnLayer()
        NotificationCenter.default.addObserver(self, selector: #selector(handleInputChange), name: UITextView.textDidChangeNotification, object: nil)
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
        //
        addSubview(inputTextField)
        inputTextField.anchor(top: topAnchor,
                              left: leftAnchor,
                              bottom: safeAreaLayoutGuide.bottomAnchor,
                              right: sendButton.leftAnchor,
                              paddingTop: 8,
                              paddingLeft: 8,
                              paddingBottom: 4,
                              paddingRight: 8)
        //
        addSubview(placeholder)
        placeholder.centerY(inView: inputTextField)
        placeholder.anchor(left: inputTextField.leftAnchor, paddingLeft: 4)
    }
    
    fileprivate func addShadowOnLayer() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 10
        layer.shadowOffset = .init(width: 0, height: -8)
    }
    
    func clearMessageField() {
        inputTextField.text = nil
        placeholder.isHidden = false
    }
    
}

//MARK: - selectors

extension CustomInputChatField {
    @objc func handleSendMessage() {
        guard let contentMessage = inputTextField.text else { return }
        delegate?.handleSendMessage(self, withMessage: contentMessage)
    }
    @objc func handleInputChange() {
        // placeholder is hidden is true only when input textfield is not empty
        placeholder.isHidden = !inputTextField.text.isEmpty
    }
}
