//
//  Conversation.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/23/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import JGProgressHUD
import GoogleMobileAds

private let reuseIdentifier = "conversationCell"

class Conversation : UITableViewController {
    
    //MARK: - properties
    
    let service = Service()
    
    private var bannerView: GADBannerView!
    
    private var user : User
    
    private let header = ConversationHeader()
    
    private var conversations : [ConversationModel] = [] {
        didSet { tableView.reloadData() }
    }
    
    private var convDictionarry : [String:ConversationModel] = [:]
    
    init(user: User) {
        self.user = user
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configNavBar()
        fetchMatches()
        fetchAllconversations()
        configBannerAds()
    }
    
}

//MARK: - helpers

extension Conversation {
    
    fileprivate func configUI() {
        tableView.register(ConversationCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 70
        tableView.sectionHeaderHeight = 200
        tableView.tableFooterView = UIView()
    }
    
    fileprivate func configNavBar() {
        let leftBtn = UIImageView(image:  #imageLiteral(resourceName: "app_icon").withRenderingMode(.alwaysTemplate))
        leftBtn.isUserInteractionEnabled = true
        leftBtn.tintColor = .lightGray
        leftBtn.setDimensions(height: 28, width: 28)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismiss))
        leftBtn.addGestureRecognizer(tap)
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBtn)
        //
        let centerBtn = UIImageView.init(image: #imageLiteral(resourceName: "top_right_messages").withRenderingMode(.alwaysTemplate))
        centerBtn.tintColor = .systemPink
        navigationItem.titleView = centerBtn
    }
    
    fileprivate func openChat(withUser user: User) {
        let chat = Chat(user: user)
        navigationController?.pushViewController(chat, animated: true)
    }
    
    fileprivate func configBannerAds() {
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        view.addSubview(bannerView)
        bannerView.setDimensions(height: 50, width: 350)
        bannerView.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        bannerView.centerX(inView: view)
        bannerView.adUnitID = bannerAdsID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
    }
    
}

//MARK: - datasource and delegate

extension Conversation {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let conversation = conversations[indexPath.row]
        openChat(withUser: conversation.user)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? ConversationCell else {
            fatalError("Error getting conversation cell at \(indexPath.row)")
        }
        cell.conversation = conversations[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header
    }
    
}

//MARK: - selectors

extension Conversation {
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - API

extension Conversation {
    
    fileprivate func fetchMatches() {
        service.fetchMatches { [weak self] matches in
            self?.header.matches = matches
            self?.header.delegate = self
        }
    }
    
    fileprivate func fetchUserAndOpenChat(withUID uid: String) {
        service.fetchUser(withUid: uid) { [weak self] result in
            switch result {
            case .success(let user):
                self?.openChat(withUser: user)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    fileprivate func fetchAllconversations() {
        //show loader
        let hud = JGProgressHUD.init(style: .dark)
        hud.show(in: view)
        //
        MessageService.shared.fetchConversations { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let conversations):
                conversations.forEach { conversation in
                    let msg = conversation.message
                    self.convDictionarry[msg.toID] = conversation
                }
                self.conversations = Array.init(self.convDictionarry.values)
                hud.dismiss(animated: true)
            case .failure(let error):
                print("error fetching conversations - \(error.localizedDescription)")
            }
        }
        hud.dismiss(animated: true)
    }
    
}

//MARK: - ConversationHeaderDelegate

extension Conversation : ConversationHeaderDelegate {
    func openConversation(_ header: ConversationHeader, withUser uid: String) {
        fetchUserAndOpenChat(withUID: uid)
    }
}

//MARK: - GADBannerViewDelegate

extension Conversation : GADBannerViewDelegate {
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
      bannerView.alpha = 0
      UIView.animate(withDuration: 1, animations: {
        bannerView.alpha = 1
      })
    }
}
