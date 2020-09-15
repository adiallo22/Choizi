//
//  Profile.swift
//  Choizi
//
//  Created by Abdul Diallo on 8/25/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import GoogleMobileAds

private var reuseIdentifier = "ProfileCell"

protocol ProfileDelegate : class {
    func handleLike(_ controller: Profile, onUser user: User)
    func handleDisLike(_ controller: Profile, onUser user: User)
    func handleSuperLike(_ controller: Profile, onUser user: User)
}

class Profile : UIViewController {
    
    //MARK: - properties
    
    private var bannerView: GADBannerView!
    
    weak var delegate : ProfileDelegate?
    
    private var user : User
    
    private lazy var viewModel = ProfileViewModel.init(user: user)
    
    private var barStack : UIStackView = {
        let stack = UIStackView()
        stack.spacing = 16
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var collectionView : UICollectionView = {
        let frame = CGRect.init(x: 0, y: 0, width: view.frame.width, height: 350)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: frame, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
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
    
    //MARK: - init
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configBannerAds()
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
        configBarStack()
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
        stack.anchor(bottom: bannerView.topAnchor,
                     paddingBottom: 6)
        stack.centerX(inView: view)
    }
    
    fileprivate func configBarStack() {
        (0 ..< viewModel.imagesCount).forEach({ indice in
            let bar = UIView()
            bar.backgroundColor = .barDeselectedColor
            barStack.addArrangedSubview(bar)
        })
        barStack.subviews.first?.backgroundColor = .white
        view.addSubview(barStack)
        barStack.setDimensions(height: 4)
        barStack.anchor(top: view.topAnchor,
                        left: view.leftAnchor,
                        right: view.rightAnchor,
                        paddingTop: 50,
                        paddingLeft: 8,
                        paddingRight: 8)
    }
    
    fileprivate func configBannerAds() {
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        view.addSubview(bannerView)
        bannerView.setDimensions(height: 50, width: 350)
        bannerView.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        bannerView.centerX(inView: view)
        bannerView.adUnitID = adsID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        barStack.arrangedSubviews.forEach({ $0.backgroundColor = .barDeselectedColor})
        barStack.arrangedSubviews[indexPath.row].backgroundColor = .white
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout

extension Profile : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

//MARK: - selectors

extension Profile {
    
    @objc func handleDislike() {
        delegate?.handleDisLike(self, onUser: user)
    }
    
    @objc func handleSuperlike() {
        delegate?.handleSuperLike(self, onUser: user)
    }
    
    @objc func handleLike() {
        delegate?.handleLike(self, onUser: user)
    }
    
    @objc func handleDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - GADBannerViewDelegate

extension Profile : GADBannerViewDelegate {
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
      bannerView.alpha = 0
      UIView.animate(withDuration: 1, animations: {
        bannerView.alpha = 1
      })
    }
}
