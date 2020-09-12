//
//  Chat.swift
//  Choizi
//
//  Created by Abdul Diallo on 9/11/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

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
        view.backgroundColor = .white
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
//        navigationItem.title = "\(user.name)"
        view.backgroundColor = .white
    }
    
}
