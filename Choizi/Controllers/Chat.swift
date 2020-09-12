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
    
    private lazy var customInputChatField : CustomInputChatField = {
        let frame = CGRect.init(x: 0, y: 0, width: view.frame.width, height: 50)
        let view = CustomInputChatField(frame: frame)
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
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.alwaysBounceVertical = true
    }
    
}

//MARK: - delegate and data source

extension Chat {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected at \(indexPath.row)")
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
    
}
