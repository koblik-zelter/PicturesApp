//
//  PopularHeaderView.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/24/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import Foundation
import UIKit

class PopularHeaderView: UICollectionReusableView {
    private let todayLabel: PTLabel = {
        let label = PTLabel(textAlignment: .left, fontSize: 24)
        label.text = "Today"
        return label
    }()
    
    private let popularLabel: PTLabel = {
        let label = PTLabel(textAlignment: .left, fontSize: 24)
        label.text = "Popular"
        return label
    }()
    
    let popularCollectionView: UICollectionView = {
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
        self.configureTodayLabel()
        self.configurePopularCollection()
        self.configurePopularLabel()
    }
    
    private func configureTodayLabel() {
        self.addSubview(todayLabel)
        todayLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        todayLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
    }
    
    private func configurePopularCollection() {
        self.addSubview(popularCollectionView)
        popularCollectionView.topAnchor.constraint(equalTo: todayLabel.bottomAnchor, constant: 16).isActive = true
        popularCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        popularCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        let width = self.bounds.width * 2 / 3
        let height = width * 1.25
        popularCollectionView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func configurePopularLabel() {
        self.addSubview(popularLabel)
        popularLabel.topAnchor.constraint(equalTo: popularCollectionView.bottomAnchor, constant: 8).isActive = true
        popularLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
    }
    
    
}
