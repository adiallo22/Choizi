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
    
    var frontCard : Card?
    var cardViews = [Card]()

    private let nav = HomeNavBar()
    
    private let footer = FooterHomeBar()
    
    private let deck : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = .black
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        checkLogStatus()
        fetchCurrentUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
}


//MARK: - helpers

extension Home {
    
    func configUI() {
        nav.delegate = self
        footer.delegate = self
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
    
    fileprivate func configCards() {
        viewModels.forEach { viewModel in
            let card = Card.init(viewModel: viewModel)
            card.delegate = self
            deck.addSubview(card)
            card.fillSuperview()
        }
        cardViews = deck.subviews.map({ $0 as! Card})
        frontCard = cardViews.last
    }
    
    fileprivate func presentLogginScreen() {
        DispatchQueue.main.async {
            let loginvc = Login()
            loginvc.delegate = self
            let nav = UINavigationController.init(rootViewController: loginvc)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    fileprivate func performAnimationOnSwipe(shouldLike: Bool) {
        let transtion = shouldLike ? 800 : -800
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.1,
                       options: .curveEaseOut,
                       animations: {
                        if let height = self.frontCard?.frame.height, let width = self.frontCard?.frame.width {
                            self.frontCard?.frame = CGRect.init(x: CGFloat(transtion),
                                                                y: 0,
                                                                width: width,
                                                                height: height)
                        }
        })
        { _ in
            self.frontCard?.removeFromSuperview()
            guard !self.cardViews.isEmpty else { return }
            self.cardViews.remove(at: self.cardViews.count - 1)
            self.frontCard = self.cardViews.last
        }
    }
    
    fileprivate func presentMatchView(forUser user: User) {
        guard let currentUSR = self.user else { return }
        let viewModel = MatchViewModel.init(currentUser: currentUSR, matchedUser: user)
        let matchView = MatchView(viewModel: viewModel)
        matchView.delegate = self
        view.addSubview(matchView)
        matchView.fillSuperview()
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
                self?.fetchAllUsers()
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    fileprivate func fetchAllUsers() {
        guard let user = user else { return }
        Service.fetchAllUsers(fromCurrentUser: user) { result in
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
    
    fileprivate func persistSwipeAndMatch(onUser user: User, withLike like: Bool, withAnimation: Bool) {
        Service.saveSwipe(onUser: user, isLike: like) { err in
            if err != nil {
                print(err!.localizedDescription)
            }
        }
        // check for matches only with swipe is right side
        if like == true {
            Service.isThereAMatch(withUser: user) { [weak self] match in
                self?.presentMatchView(forUser: user)
            }
        }
        if withAnimation == true {
            performAnimationOnSwipe(shouldLike: like)
        } else {
            self.frontCard = cardViews.last
        }
    }
    
}

//MARK: - AuthenticateDelegate

extension Home : AuthenticateDelegate {
    func finishedAuthenticating() {
        fetchCurrentUser()
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - NavigationDelegate

extension Home : NavigationDelegate {
    
    func settingTapped() {
        guard let user = user else { return }
        let setting = Setting(user: user)
        setting.delegate = self
        let nav = UINavigationController.init(rootViewController: setting)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    func conversationTapped() {
        let conversation = Conversation()
        let nav = UINavigationController.init(rootViewController: conversation)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
}

//MARK: - SettingDelegate

extension Home : SettingDelegate {
    
    func handleLoggout(_ controller: Setting) {
        controller.dismiss(animated: true, completion: nil)
        loggout()
    }
    
    func settingUpdated(_ setting: Setting, withUser user: User) {
        self.user = user
        setting.dismiss(animated: true, completion: nil)
    }
}

//MARK: - CardDelegate

extension Home : CardDelegate {
    
    func perfomPersistingSwipe(fromCard card: Card, withLike like: Bool) {
        card.removeFromSuperview()
        self.cardViews.removeAll(where: { card == $0 })
        guard let usr = frontCard?.user else { return }
        persistSwipeAndMatch(onUser: usr, withLike: like, withAnimation: false)
    }
    
    func handleShowProfile(fromCard card: Card, andUser user: User) {
        let profile = Profile.init(user: user)
        profile.modalPresentationStyle = .fullScreen
        profile.delegate = self
        present(profile, animated: true, completion: nil)
    }
    
}

//MARK: - FooterHomeBarDelegate

extension Home : FooterHomeBarDelegate {
    
    func handleSuperLike() {
        print("super like")
    }
    
    func handleLike() {
        guard let front = frontCard else { return }
        persistSwipeAndMatch(onUser: front.user, withLike: true, withAnimation: true)
        
    }
    
    func handleDisLike() {
        guard let front = frontCard else { return }
        persistSwipeAndMatch(onUser: front.user, withLike: false, withAnimation: true)
    }
    
    func handleBoost() {
        print("boost")
    }
    
    func handleRefresh() {
        print("refresh")
    }
    
}

//MARK: - ProfileDelegate

extension Home : ProfileDelegate {
    
    func handleLike(_ controller: Profile, onUser user: User) {
        controller.dismiss(animated: true) { [weak self] in
            self?.persistSwipeAndMatch(onUser: user, withLike: true, withAnimation: true)
        }
    }
    
    func handleDisLike(_ controller: Profile, onUser user: User) {
        controller.dismiss(animated: true) { [weak self] in
            self?.persistSwipeAndMatch(onUser: user, withLike: false, withAnimation: true)
        }
    }
    
    func handleSuperLike(_ controller: Profile, onUser user: User) {
        controller.dismiss(animated: true) {
            print("super liked..")
        }
    }
}

//MARK: - MatchViewDelegate

extension Home : MatchViewDelegate {
    
    func handleMessaging(toUser user: User) {
        print("sending a message to \(user.name)")
    }
    
}
