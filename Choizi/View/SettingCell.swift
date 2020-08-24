//
//  SettingCell.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/22/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class SettingCell : UITableViewCell {
    
    var viewModel : SettingViewModel? {
        didSet { configViewModel() }
    }
    
    private var input : UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.borderStyle = .none
        //
        let view = UIView()
        view.setDimensions(height: 44, width: 20)
        tf.leftView = view
        tf.leftViewMode = .always
        return tf
    }()
    
    private var minLabel : UILabel = {
        let label = UILabel()
        label.text = "Min"
        return label
    }()
    private var maxLabel : UILabel = {
        let label = UILabel()
        label.text = "Max"
        return label
    }()
    
    lazy var minSlider = creayeSlider()
    lazy var maxSlider = creayeSlider()
    
    private var stack = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
        configStacks()
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
    
    fileprivate func configStacks() {
        let minStack : UIStackView = {
            let stack = UIStackView(arrangedSubviews: [minLabel, minSlider])
            stack.spacing = 16
            return stack
        }()
        let maxStack : UIStackView = {
            let stack = UIStackView(arrangedSubviews: [maxLabel, maxSlider])
            stack.spacing = 16
            return stack
        }()
        stack = {
            let stack = UIStackView(arrangedSubviews: [minStack, maxStack])
            stack.axis = .vertical
            stack.spacing = 16
            return stack
        }()
        addSubview(stack)
        stack.centerY(inView: self)
        stack.anchor(left: leftAnchor,
                     right: rightAnchor,
                     paddingLeft: 24,
                     paddingRight: 24)
    }
    
    fileprivate func configViewModel() {
        guard let viewModel = viewModel else { return }
        input.isHidden = viewModel.shouldHideInput
        stack.isHidden = viewModel.shouldHideSlider
        input.placeholder = viewModel.placeholder
        input.text = viewModel.val
    }
    
}
