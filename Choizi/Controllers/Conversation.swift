//
//  Conversation.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/23/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

private let reuseIdentifier = "conversationCell"

class Conversation : UITableViewController {
    
    private var user : User
    
    private let header = ConversationHeader()
    
    private var conversations : [ConversationModel] = [] {
        didSet { tableView.reloadData() }
    }
    
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
    }
    
}

//MARK: - helpers

extension Conversation {
    
    fileprivate func configUI() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 50
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
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = conversations[indexPath.row].message.content
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
        Service.fetchMatches { [weak self] matches in
            self?.header.matches = matches
            self?.header.delegate = self
        }
    }
    
    fileprivate func fetchUserAndOpenChat(withUID uid: String) {
        Service.fetchUser(withUid: uid) { [weak self] result in
            switch result {
            case .success(let user):
                self?.openChat(withUser: user)
            case .failure(_):
                print("")
            }
        }
    }
    
    fileprivate func fetchAllconversations() {
        MessageService.shared.fetchConversations { result in
            switch result {
            case .success(let conversations):
                self.conversations = conversations
            case .failure(let error):
                print("error fetching conversations - \(error.localizedDescription)")
            }
        }
    }
    
}

//MARK: - ConversationHeaderDelegate

extension Conversation : ConversationHeaderDelegate {
    func openConversation(_ header: ConversationHeader, withUser uid: String) {
        fetchUserAndOpenChat(withUID: uid)
    }
}
