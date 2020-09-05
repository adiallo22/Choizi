//
//  ConversationHeader.swift
//  Choizi
//
//  Created by Abdul Diallo on 9/4/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MatchCell"

class ConversationHeader : UIView {
    
    private var NMlabel : UILabel = {
        let label = UILabel()
        label.text = "New Matches"
        label.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.register(MatchCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    private var label : UILabel = {
        let label = UILabel()
        label.text = "Messages"
        label.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - helpers

extension ConversationHeader {
    fileprivate func configUI() {
        addSubview(NMlabel)
        NMlabel.anchor(top: topAnchor,
                     left: leftAnchor,
                     paddingTop: 8,
                     paddingLeft: 12)
        //
        addSubview(collectionView)
        collectionView.anchor(top: NMlabel.bottomAnchor,
                              left: leftAnchor,
                              right: rightAnchor,
                              paddingLeft: 12,
                              paddingRight: 12)
        collectionView.setDimensions(height: 100)
        //
        addSubview(label)
        label.anchor(top: collectionView.bottomAnchor,
                     left: leftAnchor,
                     bottom: bottomAnchor,
                     right: rightAnchor,
                     paddingTop: 12,
                     paddingLeft: 12,
                     paddingBottom: 6,
                     paddingRight: 12)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension ConversationHeader : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MatchCell
        return cell
    }
    
}

//MARK: - flow layout

extension ConversationHeader : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 80, height: 100)
    }
}
