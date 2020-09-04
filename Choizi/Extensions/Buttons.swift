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
    
    func sendAMessageButton() {
        let gradient = CAGradientLayer()
        let leftColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        let rightColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        gradient.colors = [leftColor.cgColor, rightColor.cgColor]
        gradient.startPoint = CGPoint.init(x: 0, y: 0.5)
        gradient.endPoint = CGPoint.init(x: 1, y: 0.5)
        self.layer.insertSublayer(gradient, at: 0)
        layer.cornerRadius = layer.frame.size.height / 2
        layer.masksToBounds = true
    }
}
