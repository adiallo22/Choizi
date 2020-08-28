//
//  SegmentBar.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/27/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class SegmentBar : UIStackView {
    
    var elementsCount : Int!
    
    init(elementsCount: Int) {
        self.elementsCount = elementsCount
        super.init(frame: .zero)
        configUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        (0 ..< elementsCount).forEach({ indice in
            let bar = UIView()
            backgroundColor = .barDeselectedColor
            addArrangedSubview(bar)
        })
        subviews.first?.backgroundColor = .white
        spacing = 16
        axis = .horizontal
        distribution = .fillEqually
    }
    
    func highlight(atIndex index: Int) {
        arrangedSubviews.forEach({ $0.backgroundColor = .barDeselectedColor})
        arrangedSubviews[index].backgroundColor = .white
    }
    
}
