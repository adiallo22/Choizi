//
//  ChatController.swift
//  Choizi
//
//  Created by Abdul Diallo on 9/12/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class ChatController : UIViewController {
    
    var user: User?
    
    private lazy var customInputChatField : CustomInputChatField = {
        let frame = CGRect.init(x: 0, y: 0, width: view.frame.width, height: 50)
        let view = CustomInputChatField(frame: frame)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var inputAccessoryView: UIView? {
        get { return customInputChatField }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
}
