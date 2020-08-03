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
    
    private let email : UITextField = {
        let tf = UITextField()
        tf.customTextField(withPlaceholder: "Email")
        return tf
    }()
    
    private let password : UITextField = {
        let tf = UITextField()
        tf.customTextField(withPlaceholder: "Password")
        return tf
    }()
    
    private let logibButton : UIButton = {
        let button = UIButton()
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.setTitle("Login", for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor.init(white: 1, alpha: 0.2)
        button.tintColor = .white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.barStyle = .black
    }
    
}

//MARK: - helpers

extension Login {
    
    func configUI() {
        navigationController?.navigationBar.isHidden = true
        view.addSubview(logo)
        logo.setDimensions(height: 100, width: 100)
        logo.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 24)
        logo.centerX(inView: view)
        //
        let stack : UIStackView = {
           let stack = UIStackView(arrangedSubviews: [email, password, logibButton])
            stack.axis = .vertical
            stack.spacing = 16
            return stack
        }()
        view.addSubview(stack)
        stack.anchor(top: logo.bottomAnchor,
                     left: view.leftAnchor,
                     right: view.rightAnchor,
                     paddingTop: 24,
                     paddingLeft: 32,
                     paddingRight: 32)
    }
    
}
