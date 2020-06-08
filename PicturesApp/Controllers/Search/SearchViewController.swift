//
//  SearchViewController.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/24/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//
//
//import UIKit
//import MaterialComponents
//class SearchViewController13: UIViewController {
//
//    var searchController: UISearchController!
//    private var collectionView: UICollectionView!
//    private let handler = CategoryHandler()
//    private let searchContext = SearchContext(strategy: FirebaseStrategy())
//    private let strategies: [SearchStrategy] = [FirebaseStrategy(), FavoritesStrategy()]
//    private var pictures: [Picture] = []
//    private var filteredPictures: [Picture] = []
//    private var isFiltering = false
//
//    private lazy var diffableDataSource: UICollectionViewDiffableDataSource<Section, AnyHashable> = .init(collectionView: self.collectionView) { (collectionView, indexPath, object) -> UICollectionViewCell? in
//        if let object = object as? Picture {
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCellId", for: indexPath) as? TodayCell else { return UICollectionViewCell() }
//            cell.picture = object
//            return cell
//        }
//
//        if let object = object as? Category {
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCellId", for: indexPath) as? MDCChipCollectionViewCell else { return UICollectionViewCell() }
//            cell.chipView.backgroundColor = .gray
//            cell.chipView.titleLabel.textColor = .black
//            cell.chipView.titleLabel.text = "Category"
//            return cell
//
//        }
//        return nil
//    }
//
//    enum Section {
//        case categories
//        case pictures
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.backgroundColor = .systemBackground
//        self.setupCollectionView()
//        self.setupSearchBar()
//        self.getPictures()
//        // Do any additional setup after loading the view.
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        if #available(iOS 13.0, *) {
//            let navBarAppearance = UINavigationBarAppearance()
//            navBarAppearance.configureWithOpaqueBackground()
//            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
//            navBarAppearance.backgroundColor = .white
//            navigationController?.navigationBar.standardAppearance = navBarAppearance
//            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
//            self.navigationItem.title = "Search Pictures"
//            self.navigationController?.navigationBar.prefersLargeTitles = true
//            self.navigationController?.isNavigationBarHidden = false
//            self.navigationItem.hidesSearchBarWhenScrolling = false
//        }
//    }
//
//    private func setupCollectionView() {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//
//        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
//        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
//        self.collectionView.backgroundColor = .systemBackground
//
//        self.collectionView.delegate = self
//        self.collectionView.dataSource = diffableDataSource
//
//        self.collectionView.register(TodayCell.self, forCellWithReuseIdentifier: "searchCellId")
//        self.collectionView.register(MDCChipCollectionViewCell.self, forCellWithReuseIdentifier: "categoryCellId")
////        self.collectionView.register(SearchCollectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
//
//        self.view.addSubview(collectionView)
//
//        self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
//        self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
//        self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
//        self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
//    }
//
//    private func setupSearchBar() {
//        self.searchController = UISearchController(searchResultsController:  nil)
//        searchController.searchBar.delegate = self
//        searchController.searchBar.placeholder = "Search Movies"
//        self.navigationItem.searchController = searchController
//        searchController.obscuresBackgroundDuringPresentation = true
//        searchController.searchBar.barTintColor = .white
//        searchController.hidesNavigationBarDuringPresentation = true
//        navigationController?.navigationBar.isTranslucent = false
//        definesPresentationContext = true
//        searchController.searchBar.scopeButtonTitles = ["All", "Favorites"]
//
//        // To change UISegmentedControl color only when appeared in UISearchBar
//        UISegmentedControl.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .red
//    }
//
//    private func getPictures() {
//        self.showAnimation()
//        DatabaseManager.shared.getPostsFrom(path: "Popular") { [unowned self] (pictures) in
//            self.pictures.removeAll()
//            guard let pictures = pictures else { return }
//            self.pictures.append(contentsOf: pictures)
//            self.collectionView.reloadData()
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                 self.dismissAnimation()
//            }
//            self.updateDataSource(on: self.pictures)
//
//        }
//    }
//
//    fileprivate func searchPictures(_ query: String) {
//        self.filteredPictures.removeAll()
//        self.searchContext.getPictures(name: query) { [unowned self] (pictures) in
//            self.filteredPictures.append(contentsOf: pictures)
//            DispatchQueue.main.async {
//                if (self.filteredPictures.isEmpty) {
//                    self.showEmptyView(with: "Can't find that Picture", in: self.view)
//                    return
//                }
//                self.removeEmptyView()
//                self.filteredPictures.append(contentsOf: pictures)
//                self.updateDataSource(on: self.filteredPictures)
//            }
//        }
//    }
//
//    private func updateDataSource(on pictures: [Picture]) {
//        self.removeEmptyView()
//        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
//        snapshot.appendSections([.categories,.pictures])
//        snapshot.appendItems([Category(title: "Category1"), Category(title: "Category2"), Category(title: "Category3"), Category(title: "Category4"), Category(title: "Category5"), Category(title: "Category6"), Category(title: "Category7")], toSection: .categories)
//        snapshot.appendItems(pictures, toSection: .pictures)
//        DispatchQueue.main.async {
//            self.diffableDataSource.apply(snapshot, animatingDifferences: true)
//        }
//    }
//
//    func createLayout() -> UICollectionViewCompositionalLayout {
//        let layout = UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in
//            if sectionNumber == 0 {
//                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
//                item.contentInsets.bottom = 16
//                item.contentInsets.trailing = 16
//                item.contentInsets.top = 16
//
//                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .estimated(120), heightDimension: .absolute(60)), subitems: [item])
//                let section = NSCollectionLayoutSection(group: group)
//                section.orthogonalScrollingBehavior = .continuous
//                section.contentInsets.leading = 16
//                return section
//            } else {
//                // second section
//                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
//                item.contentInsets = .init(top: 0, leading: 0, bottom: 16, trailing: 16)
//
//                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250)), subitem: item, count: 1)
//
//                let section = NSCollectionLayoutSection(group: group)
////                section.orthogonalScrollingBehavior = .groupPaging
//                section.contentInsets.leading = 16
//                return section
//            }
//        }
//        return layout
//    }
//
//
//    fileprivate func reloadData() {
//        DispatchQueue.main.async {
//            self.collectionView.reloadData()
//            self.removeEmptyView()
//        }
//    }
//}
//
////extension SearchViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
//////
//////    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//////        let header = UICollectionReusableView()
//////        switch kind {
//////        case UICollectionView.elementKindSectionHeader:
//////            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId", for: indexPath) as? SearchCollectionHeader else { return UICollectionReusableView() }
//////            header.categoriesCollectionView.backgroundColor = .white
//////            header.categoriesCollectionView.register(MDCChipCollectionViewCell.self, forCellWithReuseIdentifier: "categoryId")
//////            header.categoriesCollectionView.delegate = handler
//////            header.categoriesCollectionView.dataSource = handler
//////
//////            return header
//////        default:
//////            assert(false, "Unexpected element kind")
//////        }
//////        return header
//////    }
//////
////
//////    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//////        return CGSize(width: self.collectionView.bounds.width, height: 66)
//////    }
////
//////    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//////        if (isFiltering) {
//////            return filteredPictures.count
//////        }
//////        return pictures.count
//////    }
////
//////    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//////        if (indexPath.section == 0) {
//////            let label = UILabel()
//////            label.text = "Category"
//////            label.sizeToFit()
//////            let width = label.frame.width + 32
//////            return CGSize(width: width, height: 40)
//////        }
//////        return CGSize(width: self.view.frame.width - 32, height: 250)
//////    }
//////
//////    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//////        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
//////    }
////}
////
////extension SearchViewController: UISearchBarDelegate {
////    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
////        guard let filter = searchBar.text, !filter.isEmpty else {
////            self.isFiltering = false
////            self.updateDataSource(on: self.pictures)
////            return
////        }
////
////        self.isFiltering = true
////        self.searchPictures(filter)
////        searchController.isActive = false
////        searchBar.text = filter
////    }
////
////    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
////        self.isFiltering = false
////        self.updateDataSource(on: self.pictures)
////    }
////
////    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
////        self.searchContext.setStrategy(strategies[selectedScope])
////        print("Did Change")
////    }
////}
