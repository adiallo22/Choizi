//
//  SingUp.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/3/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

protocol AuthenticateDelegate : class {
    func finishedAuthenticating()
}

class SignUp : UIViewController {
    
    weak var delegate : AuthenticateDelegate?
    
    private var viewModel = SignUpViewModel()
    
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
        tf.addTarget(self, action: #selector(tfEdited), for: .editingChanged)
        return tf
    }()
    
    private var email : UITextField = {
        let tf = UITextField()
        tf.customTextField(withPlaceholder: "Email")
        tf.addTarget(self, action: #selector(tfEdited), for: .editingChanged)
        return tf
    }()
    
    private var password : UITextField = {
        let tf = UITextField()
        tf.customTextField(withPlaceholder: "Password", andSecureEntry: true)
        tf.addTarget(self, action: #selector(tfEdited), for: .editingChanged)
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
        button.doYouHaveAcctButton(str1: "Already have an account?   ", str2: "SignIn")
        button.addTarget(self, action: #selector(segueToLogin), for: .touchUpInside)
        return button
    }()
    
    private var profile : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
}

//MARK: - helpers

extension SignUp {
    
    fileprivate func configUI() {
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
                     paddingTop: 16,
                     paddingLeft: 32,
                     paddingRight: 32)
        //
        view.addSubview(backtoLogin)
        backtoLogin.centerX(inView: view)
        backtoLogin.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    fileprivate func configButtonPhoto() {
        photoButton.layer.cornerRadius = 10
        photoButton.layer.borderWidth = 3
        photoButton.layer.borderColor = .init(srgbRed: 1, green: 1, blue: 1, alpha: 0.8)
        photoButton.imageView?.contentMode = .scaleAspectFill
        photoButton.clipsToBounds = true
    }
    
    fileprivate func buttonStatus() {
        switch viewModel.isValid {
        case true:
            signupButton.isEnabled = true
            signupButton.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        case false:
            signupButton.isEnabled = false
        }
    }
    
}

//MARK: - selectors

extension SignUp {
    
    @objc func imagePicked() {
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    @objc func signupTapped(){
        register()
        delegate?.finishedAuthenticating()
    }
    
    @objc func segueToLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func tfEdited(sender: UITextField) {
        switch sender {
        case email:
            viewModel.email = sender.text
        case password:
            viewModel.password = sender.text
        case fullname:
            viewModel.fullname = sender.text
        default:
            break
        }
        buttonStatus()
    }
    
}

//MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate

extension SignUp : UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let img = info[.originalImage] as? UIImage else { return }
        profile = img
        photoButton.setImage(img.withRenderingMode(.alwaysOriginal), for: .normal)
        configButtonPhoto()
        dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - APIS

extension SignUp {
    fileprivate func register() {
        guard let fullname = fullname.text,
            let email = email.text,
            let password = password.text,
            let profileIMG = profile else { return }
        let credential = UserCredential(fullname: fullname,
                                        email: email,
                                        password: password,
                                        profileIMG: profileIMG)
        AuthenticationService.register(withCredentials: credential) { err in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            print("successfully signed up \(credential.fullname)")
        }
    }
}
