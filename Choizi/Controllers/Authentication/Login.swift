//
//  Login.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/3/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

class Login : UIViewController {
    
    //MARK: - properties
    
    weak var delegate : AuthenticateDelegate?
    
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
    
    private let loginButton : UIButton = {
        let button = UIButton(type: .system)
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
    
    private var errorLabel : UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.barStyle = .black
        errorLabel.alpha = 0
    }
    
}

//MARK: - helpers

extension Login {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        view.resignFirstResponder()
    }
    
    func configUI() {
        navigationController?.navigationBar.isHidden = true
        view.addSubview(logo)
        logo.setDimensions(height: 100, width: 100)
        logo.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 24)
        logo.centerX(inView: view)
        //
        let stack : UIStackView = {
           let stack = UIStackView(arrangedSubviews: [email, password, loginButton])
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
        view.addSubview(errorLabel)
        errorLabel.anchor(top: loginButton.bottomAnchor,
                          paddingTop: 8)
        errorLabel.setDimensions(height: 100, width: view.frame.width - 64)
        errorLabel.centerX(inView: self.view)
        //
        view.addSubview(signupButton)
        signupButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 8)
        signupButton.centerX(inView: view)
    }

    fileprivate func buttonStatus() {
        switch viewModel.isValid {
        case true:
            loginButton.isEnabled = true
            loginButton.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        case false:
            loginButton.isEnabled = false
            loginButton.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
        }
    }
    
    fileprivate func setError(withDescription description : String) {
        errorLabel.text = description
        errorLabel.alpha = 1
    }
    
}

//MARK: - selectors

extension Login {
    
    @objc func loginTaped() {
        guard let email = email.text,
            let pwd = password.text else { return }
        //show loader
        let hud = JGProgressHUD.init(style: .dark)
        hud.show(in: view)
        AuthenticationService().signIn(withEmail: email, andPassword: pwd) { [weak self] result, err in
            if let err = err {
                self?.setError(withDescription: err.localizedDescription)
                hud.dismiss()
                return
            }
            hud.dismiss()
            self?.delegate?.finishedAuthenticating()
        }
    }
    
    @objc func segueToSignUp() {
        let signup = SignUp()
        signup.delegate = delegate
        navigationController?.pushViewController(signup, animated: true)
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
