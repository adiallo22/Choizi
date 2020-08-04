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
    
    private var fullname : UITextField = {
        let tf = UITextField()
        tf.customTextField(withPlaceholder: "Full Name")
        return tf
    }()
    
    private var email : UITextField = {
        let tf = UITextField()
        tf.customTextField(withPlaceholder: "Email")
        return tf
    }()
    
    private var password : UITextField = {
        let tf = UITextField()
        tf.customTextField(withPlaceholder: "Password")
        return tf
    }()
    
    private var signupButton : UIButton = {
        let button = UIButton()
        button.authButton(withTitle: "Sign Up")
        button.addTarget(self, action: #selector(signupTapped), for: .touchUpInside)
        return button
    }()
    
    private let backtoLogin : UIButton = {
        let button = UIButton()
        let attributed = NSMutableAttributedString.init(string: "Already have an account?   ",
                                                        attributes: [.foregroundColor: UIColor.white,
                                                                     .font: UIFont.systemFont(ofSize: 16)])
        attributed.append(NSAttributedString.init(string: "SignIn",
                                                  attributes: [.foregroundColor: UIColor.white,
                                                               .font: UIFont.boldSystemFont(ofSize: 16)]))
        button.setAttributedTitle(attributed, for: .normal)
        button.addTarget(self, action: #selector(segueToLogin), for: .touchUpInside)
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
        photoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 8)
        //
        let stack : UIStackView = {
           let stack = UIStackView(arrangedSubviews: [fullname, email, password, signupButton])
            stack.axis = .vertical
            stack.spacing = 16
            return stack
        }()
        view.addSubview(stack)
        stack.anchor(top: photoButton.bottomAnchor,
                     left: view.leftAnchor,
                     right: view.rightAnchor,
                     paddingTop: 24,
                     paddingLeft: 32,
                     paddingRight: 32)
        //
        view.addSubview(backtoLogin)
        backtoLogin.centerX(inView: view)
        backtoLogin.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
}

//MARK: - selectors

extension SignUp {
    
    @objc func imagePicked() {
        print("picked..")
    }
    
    @objc func signupTapped(){
        print("signed up..")
    }
    
    @objc func segueToLogin() {
        print("back to login..")
    }
    
}
