//
//  SettingFooter.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/24/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

protocol SettingFooterDelegate : class {
    func handleLogout()
}

class SettingFooter : UIView {
    
    weal var delegate : SettingFooterDelegate?
    
    private lazy var loggoutButton : UIButton = {
        let button = UIButton()
        button.setTitle("Loggout", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(loggoutPressed), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - helpers and configurations

extension SettingFooter {
    fileprivate func configUI() {
        let spacer = UIView()
        addSubview(spacer)
        spacer.setDimensions(height: 30, width: frame.width)
        //
        addSubview(loggoutButton)
        loggoutButton.anchor(top: spacer.bottomAnchor,
                             left: leftAnchor,
                             right: rightAnchor)
    }
}

//MARK: - selectors

extension SettingFooter {
    @objc func loggoutPressed() {
        delegate?.handleLogout()
    }
}
