//
//  Chat.swift
//  Choizi
//
//  Created by Abdul Diallo on 9/11/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MessageCell"

class Chat : UICollectionViewController {
    
    private let user : User
    
    private var messages : [Message] = []
    
    private var isCurrentUser : Bool = false
    
    private lazy var customInputChatField : CustomInputChatField = {
        let frame = CGRect.init(x: 0, y: 0, width: view.frame.width, height: 50)
        let view = CustomInputChatField(frame: frame)
        view.delegate = self
        return view
    }()
    
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configCollection()
    }
    
    override var inputAccessoryView: UIView? {
        get { return customInputChatField }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
}

//MARK: - helpers

extension Chat {
    
    fileprivate func configUI() {
        navigationItem.title = "\(user.name)"
        view.backgroundColor = .white
    }
    
    fileprivate func configCollection() {
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.alwaysBounceVertical = true
    }
    
}

//MARK: - delegate and data source

extension Chat {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MessageCell
        cell.message = messages[indexPath.row]
        return cell
    }
    
}

//MARK: - flow layout delegate

extension Chat : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.view.frame.width, height: 50)
    }
    
}

//MARK: - CustomInputChatFieldDelegate

extension Chat : CustomInputChatFieldDelegate {
    
    func handleSendMessage(_ view: CustomInputChatField, withMessage message: String) {
        view.inputTextField.text = ""
        isCurrentUser.toggle()
        let newMessage = Message.init(content: message, isCurrentUser: isCurrentUser)
        messages.append(newMessage)
        collectionView.reloadData()
    }
}
