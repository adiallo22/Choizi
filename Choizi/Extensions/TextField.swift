//
//  TextField.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/21/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

//MARK: - uitextfield

extension UITextField {
    
    func customTextField(withPlaceholder placeholder: String, andSecureEntry: Bool? = false) {
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 5)
        leftView = spacer
        leftViewMode = .always
        borderStyle = .none
        textColor = .white
        backgroundColor = UIColor.init(white: 1, alpha: 0.2)
        layer.cornerRadius = 5
        attributedPlaceholder = NSAttributedString.init(string: placeholder, attributes: [.foregroundColor:UIColor.init(white: 1, alpha: 0.8)])
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        isSecureTextEntry = andSecureEntry!
    }
    
}
