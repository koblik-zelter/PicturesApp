//
//  SearchViewController.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/24/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit
import MaterialComponents
class SearchViewController: UIViewController {
    
    var searchController: UISearchController!
    private var collectionView: UICollectionView!
    private let handler = CategoryHandler()
    private let searchContext = SearchContext(strategy: FirebaseStrategy())
    private let strategies: [SearchStrategy] = [FirebaseStrategy(), FavoritesStrategy()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.setupCollectionView()
        self.setupSearchBar()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
            navBarAppearance.backgroundColor = .white
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            self.navigationItem.title = "Search Pictures"
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationController?.isNavigationBarHidden = false
            self.navigationItem.hidesSearchBarWhenScrolling = false
        }
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
        self.collectionView.register(SearchCollectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        
        self.view.addSubview(collectionView)
        
        self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setupSearchBar() {
        self.searchController = UISearchController(searchResultsController:  nil)
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        self.navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.barTintColor = .white
        searchController.hidesNavigationBarDuringPresentation = true
        navigationController?.navigationBar.isTranslucent = false
        definesPresentationContext = true
        searchController.searchBar.scopeButtonTitles = ["All", "Favorites"]

        // To change UISegmentedControl color only when appeared in UISearchBar
        UISegmentedControl.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .red
    }
    
    fileprivate func searchPictures(_ query: String) {
        self.searchContext.getPictures(name: query) { (pictures) in
            print(pictures)
        }
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "test", for: indexPath) as? TodayCell else { return UICollectionViewCell() }
//        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = UICollectionReusableView()
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId", for: indexPath) as? SearchCollectionHeader else { return UICollectionReusableView() }
            header.categoriesCollectionView.backgroundColor = .white
            header.categoriesCollectionView.register(MDCChipCollectionViewCell.self, forCellWithReuseIdentifier: "categoryId")
            header.categoriesCollectionView.delegate = handler
            header.categoriesCollectionView.dataSource = handler

            return header
        default:
            assert(false, "Unexpected element kind")
        }
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.collectionView.bounds.width, height: 66)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 32, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        self.searchPictures(text.lowercased())
        searchController.isActive = false
        searchBar.text = text
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        self.searchContext.setStrategy(strategies[selectedScope])
        print("Did Change")
    }
}
