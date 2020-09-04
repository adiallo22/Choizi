//
//  SendAMessageButton.swift
//  Choizi
//
//  Created by Abdul Diallo on 9/3/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class SendAMessageButton : UIButton {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let gradient = CAGradientLayer()
        let leftColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        let rightColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        gradient.colors = [leftColor.cgColor, rightColor.cgColor]
        gradient.startPoint = CGPoint.init(x: 0, y: 0.5)
        gradient.endPoint = CGPoint.init(x: 1, y: 0.5)
        self.layer.insertSublayer(gradient, at: 0)
//        clipsToBounds = true
//        layer.cornerRadius = rect.height / 2
//        layer.frame = rect
    }
    
}
