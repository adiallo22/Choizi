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
        //
        header.frame = CGRect.init(x: 0, y: 0, width: view.layer.frame.size.width, height: 300)
        header.delegate = self
        //
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
    }
    
    fileprivate func configTable() {
        tableView.separatorStyle = .none
        tableView.tableHeaderView = header
    }
    
}

//MARK: - selectors

extension Setting {
    @objc func handleCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func handleDone() {
        print("done.")
    }
}

//MARK: - PickPhotoDelegate

extension Setting : PickPhotoDelegate {
    
    func pick1stPhoto(_ header: SettingHeader) {
        print(header.firstPhotoButton)
    }
    
    func pick2ndPhoto(_ header: SettingHeader) {
        print(header.secondPhotoButton)
    }
    
    func pick3rdPhoto(_ header: SettingHeader) {
        print(header.thirdPohotoButton)
    }
    
}
