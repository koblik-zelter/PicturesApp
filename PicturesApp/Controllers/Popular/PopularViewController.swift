//
//  PopularViewController.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/21/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit

fileprivate let headerId = "headerId"

class PopularViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private let handler = TodayCollectionHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupCollectionView()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showAnimation()
    }
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.backgroundColor = .systemBackground
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.register(TodayCell.self, forCellWithReuseIdentifier: "test")
        self.collectionView.register(PopularHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        self.view.addSubview(collectionView)
      
        self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension PopularViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "test", for: indexPath) as? TodayCell else { return UICollectionViewCell() }
//        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = UICollectionReusableView()
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId, for: indexPath) as? PopularHeaderView else { return UICollectionReusableView() }
            header.popularCollectionView.backgroundColor = .white
            header.popularCollectionView.register(PopularCell.self, forCellWithReuseIdentifier: "todayCellId")
            header.popularCollectionView.delegate = handler
            header.popularCollectionView.dataSource = handler

            return header
        default:
            assert(false, "Unexpected element kind")
        }
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = self.view.bounds.width * 2 / 3
        let height = width * 1.25 + 100
        return CGSize(width: self.collectionView.bounds.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 32, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
    }
}
