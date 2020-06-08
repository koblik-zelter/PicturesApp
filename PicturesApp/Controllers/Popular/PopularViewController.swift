//
//  PopularViewController.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/21/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit
import Firebase
fileprivate let headerId = "headerId"

class PopularViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private let handler = TodayCollectionHandler()
    fileprivate var pictures: [Picture] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        NotificationCenter.default.addObserver(self, selector: #selector(getPictures), name: .init("didRegister"), object: nil)
        self.setupCollectionView()
//        self.getPictures()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.backgroundColor = .init(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        
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
    
    @objc private func getPictures() {
        self.showAnimation()
        DatabaseManager.shared.getPostsFrom(path: "Popular") { [unowned self] (pictures) in
            self.pictures.removeAll()
            guard let pictures = pictures else { return }
            self.pictures.append(contentsOf: pictures)
            self.handler.appendPictures(pictures: pictures)
            DispatchQueue.main.async {
                 self.collectionView.reloadData()
                 NotificationCenter.default.post(name: Notification.Name("newTopPictures"), object: nil)
                 DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                      self.dismissAnimation()
                 }
             }
        }
    }
}

extension PopularViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "test", for: indexPath) as? TodayCell else { return UICollectionViewCell() }
        cell.picture = pictures[indexPath.item]
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
        let width = self.view.bounds.width / 2
        let height = width * 1.5 + 100
        return CGSize(width: self.collectionView.bounds.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PictureDetailsViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.picture = pictures[indexPath.item]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 32, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
    }
}

extension PopularViewController: Observable {
    func updateData(for user: User) {
        self.getPictures()
    }
}


/*
 //        items.append(Picture(title: "Adele", description: "Adele picture by Shika Treibich", imageLink: "gs://pictureapp-807a9.appspot.com/a.jpg", initialPrice: 150, authorID: "12345"))
 //        items.append(Picture(title: "Miss Modular", description: "Miss Modular picture by Shika Treibich", imageLink: "gs://pictureapp-807a9.appspot.com/bbllll.jpg", initialPrice: 210, authorID: "12345"))
 //        items.append(Picture(title: "First Woman", description: "First Woman by Shika Treibich", imageLink: "gs://pictureapp-807a9.appspot.com/bwd.jpg", initialPrice: 230, authorID: "12345"))
 //        items.append(Picture(title: "Dana Katherine Scully", description: "Dana Katherine Scull by Shika Treibich", imageLink: "gs://pictureapp-807a9.appspot.com/dks.jpg", initialPrice: 300, authorID: "12345"))
 //        items.append(Picture(title: "Woman in Glasses", description: "Woman in Glasses by Shika Treibich", imageLink: "gs://pictureapp-807a9.appspot.com/ffff.png", initialPrice: 170, authorID: "12345"))
 //        items.append(Picture(title: "Second Woman", description: "Second Woman by Shika Treibich", imageLink: "gs://pictureapp-807a9.appspot.com/bwd 2.jpg", initialPrice: 230, authorID: "12345"))
 //        items.forEach { DatabaseManager.shared.postImage(picture: $0) }
 */
