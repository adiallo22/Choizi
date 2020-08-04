//
//  SingUp.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/3/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class SignUp : UIViewController {
    
    private var photoButton : UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.addTarget(self, action: #selector(imagePicked), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
}

//MARK: - helpers

extension SignUp {
    
    func configUI() {
        view.addSubview(photoButton)
        photoButton.setDimensions(height: 270, width: 270)
        photoButton.centerX(inView: view)
        photoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 24)
    }
    
}

//MARK: - selectors

extension SignUp {
    
    @objc func imagePicked() {
        print("picked..")
    }
    
}
