//
//  CategoryHandler.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/24/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit
import MaterialComponents

class CategoryHandler: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryId", for: indexPath) as? MDCChipCollectionViewCell else { return UICollectionViewCell() }
        cell.chipView.backgroundColor = .gray
        cell.chipView.titleLabel.textColor = .black
        cell.chipView.titleLabel.text = "Category"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.text = "Category"
        label.sizeToFit()
        let width = label.frame.width + 32
        return CGSize(width: width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        print(indexPath.item)
//        self.delegate?.didSelectCategory(categories[indexPath.item - 1])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 0)
    }
}

extension MDCChipCollectionViewCell {
    open override func prepareForReuse() {
        super.prepareForReuse()
        chipView.imageView.image = nil
        chipView.imagePadding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        chipView.titleLabel.text = ""
    }
}
