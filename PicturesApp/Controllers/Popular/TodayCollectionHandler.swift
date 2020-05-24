//
//  TodayCollectionHandler.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/24/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit

class TodayCollectionHandler: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
//    var movies: [Movie] = []
    
  /*  func appendMovies(movies: [Movie]) {
        self.movies.removeAll()
        self.movies.append(contentsOf: movies)
    }*/
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "todayCellId", for: indexPath) as? PopularCell else { return UICollectionViewCell() }
//        cell.movie = movies[indexPath.item]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width * 2 / 3
        let height = width * 1.25
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
}
