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
        Service.fetchLikedUser { (users) in
            print("users are - \(users)")
        }
    }
    
}

//MARK: - helpers

extension Conversation {
    
    fileprivate func configUI() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 50
        tableView.sectionHeaderHeight = 100
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
    
}

//MARK: - datasource and delegate

extension Conversation {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
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
