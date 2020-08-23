//
//  SettingCell.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/22/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class SettingCell : UITableViewCell {
    
    private var input : UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.borderStyle = .none
        tf.placeholder = "Enter here.."
        //
        let view = UIView()
        view.setDimensions(height: 50, width: 20)
        tf.leftView = view
        tf.leftViewMode = .always
        return tf
    }()
    
    lazy var min = creayeSlider()
    lazy var max = creayeSlider()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - helpers

extension SettingCell {
    
    fileprivate func configUI() {
        addSubview(input)
        input.fillSuperview()
    }
    
    fileprivate func creayeSlider() -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 18
        slider.maximumValue = 60
        return slider
    }
    
}
