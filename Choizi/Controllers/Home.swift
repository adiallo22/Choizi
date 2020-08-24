//
//  Home.swift
//  Choizi
//
//  Created by Abdul Diallo on 7/28/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import FirebaseAuth

class Home : UIViewController {
    
    private var user : User?
    
    private var viewModels : [CardViewModel] = [] {
        didSet { configCards() }
    }

    private let nav = HomeNavBar()
    
    private let footer = FooterHomeBar()
    
    private let deck : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        checkLogStatus()
        fetchCurrentUser()
        fetchAllUsers()
//        loggout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
}


//MARK: - helpers

extension Home {
    
    func configUI() {
        nav.delegate = self
        let stack : UIStackView = {
            let stack = UIStackView(arrangedSubviews: [nav, deck, footer])
            stack.axis = .vertical
            stack.isLayoutMarginsRelativeArrangement = true
            stack.layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
            stack.bringSubviewToFront(deck)
            return stack
        }()
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
        
    }
    
    func configCards() {
        viewModels.forEach { viewModel in
            let card = Card.init(viewModel: viewModel)
            deck.addSubview(card)
            card.fillSuperview()
        }
    }
    
    fileprivate func presentLogginScreen() {
        DispatchQueue.main.async {
            let loginvc = Login()
            let nav = UINavigationController.init(rootViewController: loginvc)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    
}

//MARK: - APIS

extension Home {
    
    fileprivate func checkLogStatus() {
        if Auth.auth().currentUser?.uid == nil {
            presentLogginScreen()
        } else {
            print("user IS logged in")
        }
    }
    
    fileprivate func loggout() {
        do {
            try Auth.auth().signOut()
            presentLogginScreen()
        } catch {
            print("error signing out user")
        }
    }
    
    fileprivate func fetchCurrentUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Service.fetchUser(withUid: uid) { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    fileprivate func fetchAllUsers() {
        Service.fetchAllUsers { result in
            switch result {
            case .success(let users):
                users.forEach { [weak self] user in
                    let viewModel = CardViewModel.init(user: user)
                    self?.viewModels.append(viewModel)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
}

//MARK: - NavigationDelegate

extension Home : NavigationDelegate {
    
    func settingTapped() {
        guard let user = user else { return }
        let setting = Setting(user: user)
        let nav = UINavigationController.init(rootViewController: setting)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    func conversationTapped() {
        print("conversation")
    }
    
}
