//
//  Setting.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/21/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import JGProgressHUD
import GoogleMobileAds

private let reusableIdentifier = "SettingCell"

protocol SettingDelegate : class {
    func settingUpdated(_ setting: Setting, withUser user: User)
    func handleLoggout(_ controller: Setting)
}

class Setting : UITableViewController {
    
    //MARK: - properties
    
    let service = Service()
    
    private var user : User
    private lazy var header = SettingHeader(user: user)
    private let footer = SettingFooter()
    private let picker = UIImagePickerController()
    weak var delegate : SettingDelegate?
    
    private var index = 0
    
    //MARK: - init
    
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
        configTable()
    }
    
}

//MARK: - helpers and configurations

extension Setting {
    
    fileprivate func configUI() {
        navigationItem.title = "Setting"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        //config header
        header.frame = CGRect.init(x: 0, y: 0, width: view.layer.frame.size.width, height: 300)
        header.delegate = self
        picker.delegate = self
        //config footer
        footer.frame = CGRect.init(x: 0, y: 0, width: view.layer.frame.size.width, height: 140)
        footer.delegate = self
        footer.bannerView.delegate = self
        footer.bannerView.rootViewController = self
        //add bar buttons
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
    }
    
    fileprivate func configTable() {
        tableView.separatorStyle = .none
        tableView.tableHeaderView = header
        tableView.register(SettingCell.self, forCellReuseIdentifier: reusableIdentifier)
        tableView.sectionHeaderHeight = 32
        tableView.backgroundColor = .systemGroupedBackground
        tableView.tableFooterView = footer
        tableView.keyboardDismissMode = .interactive
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
        view.endEditing(true)
        let hud = JGProgressHUD.init(style: .dark)
        hud.textLabel.text = "Saving photo.."
        hud.show(in: view)
        service.saveData(withUser: user) { [weak self] err in
            guard let self = self else { return }
            self.delegate?.settingUpdated(self, withUser: self.user)
        }
        hud.dismiss()
    }
}

//MARK: - API

extension Setting {
    fileprivate func uploadImages(image: UIImage) {
        let hud = JGProgressHUD.init(style: .dark)
        hud.textLabel.text = "Saving photo.."
        hud.show(in: view)
        service.uploadImage(image: image) { result in
            switch result {
            case .success(let url):
                self.user.images.append(url)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
        hud.dismiss()
    }
}

//MARK: - delegate and datasource

extension Setting {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingSections.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier, for: indexPath) as! SettingCell
        guard let setting = SettingSections.init(rawValue: indexPath.section) else { return cell }
        let viewModel = SettingViewModel(user: user, setting: setting)
        cell.viewModel = viewModel
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let title = SettingSections.init(rawValue: section)?.description else { return nil }
        return title
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let sec = SettingSections.init(rawValue: indexPath.section) else { return 0 }
        return sec == .seekingRangeAge ? 96 : 44
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
        uploadImages(image: image)
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - EditTextFieldDelegate

extension Setting : EditTextFieldDelegate {
    
    func settingCellSlider(_ cell: SettingCell, withSlider slider: UISlider) {
        if slider == cell.minSlider {
            user.seekingMinAge = Int(slider.value)
        } else {
            user.seekingMaxAge = Int(slider.value)
        }
    }
    
    func finishedEditing(_ cell: SettingCell, withText text: String, andSetting setting: SettingSections) {
        switch setting {
        case .name:
            user.name = text
        case .profession:
            user.profession = text
        case .age:
            user.age = Int(text) ?? user.age
        case .bio:
            user.bio = text
        case .seekingRangeAge:
            break
        }
    }
    
}

//MARK: - SettingFooterDelegate

extension Setting : SettingFooterDelegate {
    
    func handleLogout() {
        delegate?.handleLoggout(self)
    }
}

//MARK: - GADBannerViewDelegate

extension Setting : GADBannerViewDelegate {
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        footer.bannerView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            self.footer.bannerView.alpha = 1
        })
    }
}
