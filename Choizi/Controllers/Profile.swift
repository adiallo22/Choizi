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
    
    private lazy var collectionView : UICollectionView = {
        let frame = CGRect.init(x: 0, y: 0, width: 200, height: 300)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: frame, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.isPagingEnabled = true
        collection.register(ProfileCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        return collection
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
    }
    
}

//MARK: - helpers

extension Profile {
    
    fileprivate func configUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        //
        view.addSubview(collectionView)
    }
    
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension Profile : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProfileCell
        return cell
    }
    
}
