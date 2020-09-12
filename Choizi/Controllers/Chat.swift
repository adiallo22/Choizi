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
    
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
