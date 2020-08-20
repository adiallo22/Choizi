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
        configCards()
        checkLogStatus()
    }
    
}


//MARK: - helpers

extension Home {
    
    func configUI() {
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
        let user1 = User.init(name: "dylan", age: 0, photos: [#imageLiteral(resourceName: "Wtfv8VY8I2RDhbQlIvSqORBAx1N2")])
        let user2 = User.init(name: "amadou", age: 0, photos: [#imageLiteral(resourceName: "Wtfv8VY8I2RDhbQlIvSqORBAx1N2")])
        let card1 = Card(viewModel: CardViewModel.init(user: user1))
        let card2 = Card(viewModel: CardViewModel.init(user: user2))
        deck.addSubview(card1)
        deck.addSubview(card2)
        card1.fillSuperview()
        card2.fillSuperview()
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
    
    func checkLogStatus() {
        if Auth.auth().currentUser == nil {
            presentLogginScreen()
        } else {
            print("user IS logged in")
        }
    }
    
    func loggout() {
        do {
            try Auth.auth().signOut()
            presentLogginScreen()
        } catch {
            print("error signing out user")
        }
    }
    
}
