//
//  Buttons.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/21/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

//MARK: - uibutton

extension UIButton {
    
    func authButton(withTitle title: String) {
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        setTitle(title, for: .normal)
        layer.cornerRadius = 5
        backgroundColor = UIColor.init(white: 1, alpha: 0.5)
        tintColor = .white
    }
    
    func doYouHaveAcctButton(str1: String, str2: String) {
        let attributed = NSMutableAttributedString.init(string: str1,
                                                        attributes: [.foregroundColor: UIColor.white,
                                                                     .font: UIFont.systemFont(ofSize: 16)])
        attributed.append(NSAttributedString.init(string: str2,
                                                  attributes: [.foregroundColor: UIColor.white,
                                                               .font: UIFont.boldSystemFont(ofSize: 16)]))
        setAttributedTitle(attributed, for: .normal)
    }
    
    func createPhotoButton() {
        layer.cornerRadius = 10
        clipsToBounds = true
        imageView?.contentMode = .scaleAspectFill
        backgroundColor = .white
        setTitle("Select Photo", for: .normal)
        setTitleColor(.black, for: .normal)
    }
}
