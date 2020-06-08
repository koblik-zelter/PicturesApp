//
//  SearchCategoryViewController.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 6/7/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit
import MaterialComponents

class SearchCategoryViewController: UIViewController {

    var searchController: UISearchController!
    private var collectionView: UICollectionView!
    private let handler = CategoryHandler()
    private let searchContext = SearchContext(strategy: FirebaseStrategy())
    private let strategies: [SearchStrategy] = [FirebaseStrategy(), FavoritesStrategy()]
    private var pictures: [Picture] = []
    private var filteredPictures: [Picture] = []
    private var isFiltering = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.setupCollectionView()
        self.setupSearchBar()
        self.getPictures()
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
        
        self.collectionView.register(TodayCell.self, forCellWithReuseIdentifier: "searchCellId")
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
    
    private func getPictures() {
        self.showAnimation()
        DatabaseManager.shared.getPostsFrom(path: "Popular") { [unowned self] (pictures) in
            self.pictures.removeAll()
            guard let pictures = pictures else { return }
            self.pictures.append(contentsOf: pictures)
            self.collectionView.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.dismissAnimation()
            }
        }
    }
    
    fileprivate func searchPictures(_ query: String) {
        self.filteredPictures.removeAll()
        self.searchContext.getPictures(name: query) { [unowned self] (pictures) in
            DispatchQueue.main.async {
                self.filteredPictures.append(contentsOf: pictures)
                if (self.filteredPictures.isEmpty) {
                    self.showAlert(title: "No Results", message: "Can't find that Picture", action: "Ok")
                    //self.showEmptyView(with: "Can't find that Picture", in: self.view)
                    return
                }
                self.collectionView.reloadData()
            }
        }
    }
    
    fileprivate func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension SearchCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCellId", for: indexPath) as? TodayCell else { return UICollectionViewCell() }
        cell.picture = isFiltering ? filteredPictures[exist: indexPath.item] : pictures[exist: indexPath.item]
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let picture = isFiltering ? filteredPictures[exist: indexPath.item] : pictures[exist: indexPath.item]
        let vc = PictureDetailsViewController()
        vc.picture = picture
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.collectionView.bounds.width, height: 66)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (isFiltering) {
            return filteredPictures.count
        }
        return pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 32, height: 250)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
}

extension SearchCategoryViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let filter = searchBar.text, !filter.isEmpty else {
            self.isFiltering = false
            self.reloadData()
            return
        }
        
        self.isFiltering = true
        self.searchController.isActive = false
        self.searchPictures(filter)
        searchBar.text = filter
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.isFiltering = false
        self.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        self.searchContext.setStrategy(strategies[selectedScope])
    }
}
