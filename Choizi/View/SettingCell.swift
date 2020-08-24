//
//  SettingCell.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/22/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

protocol EditTextFieldDelegate: class {
    func finishedEditing(_ cell: SettingCell, withText text: String, andSetting setting: SettingSections)
    func settingCellSlider(_ cell: SettingCell, withSlider slider: UISlider)
}

class SettingCell : UITableViewCell {
    
    weak var delegate : EditTextFieldDelegate?
    
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
        return label
    }()
    private var maxLabel : UILabel = {
        let label = UILabel()
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
        selectionStyle = .none
        //
        addSubview(input)
        input.fillSuperview()
        input.addTarget(self, action: #selector(didFinishEditingTF), for: .editingDidEnd)
    }
    
    fileprivate func creayeSlider() -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 18
        slider.maximumValue = 60
        slider.addTarget(self, action: #selector(editSlider), for: .valueChanged)
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
        stack.isHidden = viewModel.shouldHideSlider
        input.isHidden = viewModel.shouldHideInput
        input.placeholder = viewModel.placeholder
        input.text = viewModel.val
        //
        minLabel.text = viewModel.minAgeSeekingLabel(value: viewModel.minAgeSlider)
        maxLabel.text = viewModel.maxAgeSeekingLabel(value: viewModel.maxAgeSlider)
        //
        minSlider.setValue(viewModel.minAgeSlider, animated: true)
        maxSlider.setValue(viewModel.maxAgeSlider, animated: true)
    }
    
}

//MARK: - selector

extension SettingCell {
    @objc func didFinishEditingTF(sender: UITextField) {
        guard let text = sender.text,
            let setting = viewModel?.setting else { return }
        delegate?.finishedEditing(self, withText: text, andSetting: setting)
    }
    @objc func editSlider(sender: UISlider) {
        if sender == minSlider {
            minLabel.text = viewModel?.minAgeSeekingLabel(value: sender.value)
        } else {
            maxLabel.text = viewModel?.maxAgeSeekingLabel(value: sender.value)
        }
        delegate?.settingCellSlider(self, withSlider: sender)
    }
}
