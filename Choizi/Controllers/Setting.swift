//
//  Setting.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/21/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

private let reusableIdentifier = "SettingCell"

class Setting : UITableViewController {
    
    private let header = SettingHeader()
    private let picker = UIImagePickerController()
    
    private var index = 0
    
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
        picker.delegate = self
        //
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
    }
    
    fileprivate func configTable() {
        tableView.separatorStyle = .none
        tableView.tableHeaderView = header
        tableView.register(SettingCell.self, forCellReuseIdentifier: reusableIdentifier)
        tableView.sectionHeaderHeight = 32
    }
    
    fileprivate func setHeaderButtonIMG(withImage image: UIImage?, atIndex index: Int) {
        if index == 0 {
            header.firstPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
            return
        }
        if index == 1 {
            header.secondPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
            return
        }
        if index == 2 {
            header.thirdPohotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
            return
        }
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

//MARK: - delegate and datasource

extension Setting {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingSections.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier, for: indexPath) as! SettingCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let title = SettingSections.init(rawValue: section)?.description else { return nil }
        return title
    }
}

//MARK: - PickPhotoDelegate

extension Setting : PickPhotoDelegate {
    
    func pick1stPhoto(_ header: SettingHeader) {
        index = 0
        present(picker, animated: true, completion: nil)
    }
    
    func pick2ndPhoto(_ header: SettingHeader) {
        index = 1
        present(picker, animated: true, completion: nil)
    }
    
    func pick3rdPhoto(_ header: SettingHeader) {
        index = 2
        present(picker, animated: true, completion: nil)
    }
    
}

//MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate

extension Setting : UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        setHeaderButtonIMG(withImage: image, atIndex: index)
        dismiss(animated: true, completion: nil)
    }
}
