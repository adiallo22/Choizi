//
//  SingUp.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/3/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import JGProgressHUD

protocol AuthenticateDelegate : class {
    func finishedAuthenticating()
    func finishedSigningUp(withUID uid: String)
}

class SignUp : UIViewController {
    
    //MARK: - properties
    
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
        let button = UIButton(type: .system)
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
    
    //MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        moveKepboardUp()
    }
    
}

//MARK: - keyboard handler

extension SignUp {
    
    func moveKepboardUp() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        view.resignFirstResponder()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 100
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
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
            signupButton.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        case false:
            signupButton.isEnabled = false
            signupButton.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
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
        let hud = JGProgressHUD.init(style: .dark)
        hud.show(in: view)
        let credential = UserCredential(fullname: fullname,
                                        email: email,
                                        password: password,
                                        profileIMG: profileIMG)
        AuthenticationService.register(withCredentials: credential) { [weak self] uid, err  in
            if let err = err {
                print(err.localizedDescription)
                hud.dismiss()
                return
            }
            hud.dismiss()
            guard let uid = uid else { return }
            self?.delegate?.finishedSigningUp(withUID: uid)
            self?.delegate?.finishedAuthenticating()
            print("successfully signed up \(credential.fullname)")
        }
    }
}
