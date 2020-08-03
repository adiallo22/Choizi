//
//  Login.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/3/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class Login : UIViewController {
    
    private var logo : UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "app_icon").withRenderingMode(.alwaysTemplate)
        img.tintColor = .white
        return img
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
}

//MARK: - helpers

extension Login {
    
    func configUI() {
        navigationController?.navigationBar.isHidden = true
        view.addSubview(logo)
        logo.setDimensions(height: 100, width: 100)
        logo.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 10)
        logo.centerX(inView: view)
    }
    
}
