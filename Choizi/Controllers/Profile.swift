//
//  Profile.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/25/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

private var reuseIdentifier = "ProfileCell"

class Profile : UIViewController {
    
    private var user : User
    
    private lazy var viewModel = ProfileViewModel.init(user: user)
    
    private lazy var collectionView : UICollectionView = {
        let frame = CGRect.init(x: 0, y: 0, width: view.frame.width, height: view.frame.width+100)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: frame, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.isPagingEnabled = true
        collection.register(ProfileCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        return collection
    }()
    
    private var dismissButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "dismiss_down_arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    private var infoLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.numberOfLines = 0
        return label
    }()
    
    private var professionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private var bioLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dislikeButton : UIButton = {
        let button = createButton(withImage: #imageLiteral(resourceName: "dismiss_circle"))
        button.addTarget(self, action: #selector(handleDislike), for: .touchUpInside)
        return button
    }()
    
    private lazy var superlikeButton : UIButton = {
        let button = createButton(withImage: #imageLiteral(resourceName: "super_like_circle"))
        button.addTarget(self, action: #selector(handleSuperlike), for: .touchUpInside)
        return button
    }()
    
    private lazy var likeButton : UIButton = {
        let button = createButton(withImage: #imageLiteral(resourceName: "like_circle"))
        button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        return button
    }()
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configViewModel()
    }
    
}

//MARK: - helpers

extension Profile {
    
    fileprivate func configViewModel() {
        infoLabel.attributedText = viewModel.userInfo
        bioLabel.text = viewModel.bio
        professionLabel.text = viewModel.profession
    }
    
    fileprivate func configUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        //
        view.addSubview(collectionView)
        //
        view.addSubview(dismissButton)
        dismissButton.setDimensions(height: 40, width: 40)
        dismissButton.anchor(top: collectionView.bottomAnchor,
                             right: view.rightAnchor,
                             paddingTop: -24,
                             paddingRight: 20)
        //
        let stack : UIStackView = {
            let stack = UIStackView(arrangedSubviews: [infoLabel, professionLabel, bioLabel])
            stack.spacing = 5
            stack.axis = .vertical
            return stack
        }()
        view.addSubview(stack)
        stack.anchor(top: collectionView.bottomAnchor,
                     left: view.leftAnchor,
                     right: view.rightAnchor,
                     paddingTop: 20,
                     paddingLeft: 16,
                     paddingRight: 16)
        configStackButtons()
        
    }
    
    fileprivate func createButton(withImage image: UIImage) -> UIButton {
        let button = UIButton()
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }
    
    fileprivate func configStackButtons() {
        let stack : UIStackView = {
            let stack = UIStackView.init(arrangedSubviews: [dislikeButton, superlikeButton, likeButton])
            stack.axis = .horizontal
            stack.alignment = .center
            stack.spacing = 30
            return stack
        }()
        view.addSubview(stack)
        stack.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                     paddingBottom: 30)
        stack.centerX(inView: view)
//        stack.setDimensions(height: 60)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension Profile : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.imagesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProfileCell
        cell.userIMG.sd_setImage(with: viewModel.imageURLs[indexPath.row])
        return cell
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout

extension Profile : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.width+100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

//MARK: - selectors

extension Profile {
    
    @objc func handleDislike() {
        print("dislike")
    }
    
    @objc func handleSuperlike() {
        print("superlike")
    }
    
    @objc func handleLike() {
        print("like")
    }
    
    @objc func handleDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}
