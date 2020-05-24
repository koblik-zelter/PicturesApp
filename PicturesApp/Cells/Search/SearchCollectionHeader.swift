//
//  SearchCollectionHeader.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/24/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit
import MaterialComponents

class SearchCollectionHeader: UICollectionReusableView {
    
    let categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .init(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        collectionView.decelerationRate = .fast
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(categoriesCollectionView)
        categoriesCollectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        categoriesCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        categoriesCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        categoriesCollectionView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
