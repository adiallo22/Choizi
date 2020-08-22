//
//  Setting.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/21/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class Setting : UITableViewController {
    
    private let header = SettingHeader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configTable()
    }
    
}

//MARK: - helpers

extension Setting {
    
    fileprivate func configUI() {
        navigationItem.title = "Setting"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        header.frame = CGRect.init(x: 0, y: 0, width: view.layer.frame.size.width, height: 300)
    }
    
    fileprivate func configTable() {
        tableView.separatorStyle = .none
        tableView.tableHeaderView = header
    }
    
}
