//
//  Home.swift
//  Choizi
//
//  Created by Abdul Diallo on 7/28/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class Home : UIViewController {

    private let nav = HomeNavBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
}


//MARK: - helpers

extension Home {
    
    func configUI() {
        view.addSubview(nav)
        nav.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor)
    }
    
}
