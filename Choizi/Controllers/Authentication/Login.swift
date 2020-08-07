//
//  Login.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/3/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class Login : UIViewController {
    
    private var viewModel = LoginViewModel()
    
    private var logo : UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "app_icon").withRenderingMode(.alwaysTemplate)
        img.tintColor = .white
        return img
    }()
    
    private let email : UITextField = {
        let tf = UITextField()
        tf.customTextField(withPlaceholder: "Email")
        tf.addTarget(self, action: #selector(emailOrPwdEdited), for: .editingChanged)
        return tf
    }()
    
    private let password : UITextField = {
        let tf = UITextField()
        tf.customTextField(withPlaceholder: "Password", andSecureEntry: true)
        tf.addTarget(self, action: #selector(emailOrPwdEdited), for: .editingChanged)
        return tf
    }()
    
    private let logibButton : UIButton = {
        let button = UIButton()
        button.authButton(withTitle: "Login")
        button.addTarget(self, action: #selector(loginTaped), for: .touchUpInside)
        return button
    }()
    
    private let signupButton : UIButton = {
        let button = UIButton()
        button.doYouHaveAcctButton(str1: "Don't have an account?   ", str2: "SignUp")
        button.addTarget(self, action: #selector(segueToSignUp), for: .touchUpInside)
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
        //
        view.addSubview(signupButton)
        signupButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 8)
        signupButton.centerX(inView: view)
    }

    fileprivate func buttonStatus() {
        switch viewModel.isValid {
        case true:
            logibButton.isEnabled = true
            logibButton.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        case false:
            logibButton.isEnabled = false
        }
    }
    
}

//MARK: - selectors

extension Login {
    
    @objc func loginTaped() {
        print("logged in..")
    }
    
    @objc func segueToSignUp() {
        navigationController?.pushViewController(SignUp(), animated: true)
    }
    
    @objc func emailOrPwdEdited(sender: UITextField) {
        switch sender {
        case email:
            viewModel.email = sender.text
        case password:
            viewModel.password = sender.text
        default:
            break
        }
        buttonStatus()
    }
    
    
}
