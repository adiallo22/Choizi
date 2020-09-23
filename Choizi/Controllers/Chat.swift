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
    
    //MARK: - properties
    
    private let user : User
    
    private var messages : [Message] = [] {
        didSet { collectionView.reloadData() }
    }
    
    private var isCurrentUser : Bool = false
    
    private lazy var customInputChatField : CustomInputChatField = {
        let frame = CGRect.init(x: 0, y: 0, width: view.frame.width, height: 50)
        let view = CustomInputChatField(frame: frame)
        view.delegate = self
        return view
    }()
    
    private var moreBarButton : UIImageView = {
        let view = UIImageView()
        view.image = UIImage.init(systemName: "eye")?.withRenderingMode(.alwaysOriginal)
        view.contentMode = .scaleAspectFill
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
        fetchMessages()
        setRightBarButton()
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
        collectionView.backgroundColor = .white
        navigationItem.title = "\(user.name)"
        collectionView.allowsSelection = false
        collectionView.keyboardDismissMode = .interactive
    }
    
    fileprivate func configCollection() {
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.alwaysBounceVertical = true
    }
    
    fileprivate func setRightBarButton() {
        let rightBarButton = UIBarButtonItem(image: moreBarButton.image,
                                             style: .plain,
                                             target: self,
                                             action: #selector(handleShowProfile))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    fileprivate func openProfile(of user: User) {
        let profile = Profile.init(user: user, isAlradyLiked: true)
        navigationController?.pushViewController(profile, animated: true)
    }
    
}

//MARK: - selectors

extension Chat {
    @objc func handleShowProfile() {
        openProfile(of: user)
    }
}

//MARK: - delegate and data source

extension Chat {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MessageCell else {
            fatalError("Error getting cell at \(indexPath.row)")
        }
        cell.message = messages[indexPath.row]
        cell.message?.user = user
        return cell
    }
    
}

//MARK: - flow layout delegate

extension Chat : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 50)
        let estimatedCellSize = MessageCell.init(frame: frame)
        estimatedCellSize.message = messages[indexPath.row]
        estimatedCellSize.layoutIfNeeded()
        let targetSize = CGSize.init(width: self.view.frame.width, height: 1000)
        let estimatedSize = estimatedCellSize.systemLayoutSizeFitting(targetSize)
        return .init(width: self.view.frame.width, height: estimatedSize.height)
    }
    
}

//MARK: - APIS

extension Chat {
    fileprivate func uploadMessage(message: String, to user: User) {
        MessageService.shared.uploadMessage(message, to: user) { error in
            if let error = error {
                print("error uploading message - \(error.localizedDescription)")
            }
        }
    }
    
    fileprivate func fetchMessages() {
        MessageService.shared.fetchMessage(for: user) { [weak self] result in
            switch result {
            case .success(let messages):
                self?.messages = messages
                self?.collectionView.scrollToItem(at: [0, (self?.messages.count)! - 1], at: .bottom, animated: true)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: - CustomInputChatFieldDelegate

extension Chat : CustomInputChatFieldDelegate {
    
    func handleSendMessage(_ view: CustomInputChatField, withMessage message: String) {
        uploadMessage(message: message, to: user)
        view.clearMessageField()
        collectionView.reloadData()
    }
}
