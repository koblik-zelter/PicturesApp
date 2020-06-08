//
//  UserViewController.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/21/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit
import Firebase
import SafariServices

class UserViewController: UIViewController {

    private let headerView = UIView()
    private let firstItemPlaceHolder = UIView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private var collectionView: UICollectionView!
    private var currentUser: Author!
    private var favoritesLabel: PTLabel = {
        let label = PTLabel(textAlignment: .left, fontSize: 22)
        label.text = "Favorites"
        return label
    }()
    
    private func configureNavigationBar() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(selectAnimation))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    private var pictures: [Picture] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.configureNavigationBar()
        self.configureScrollView()
        self.setupViews()
        self.setupChilds()
        self.setupCollectionView()
        self.showAnimation()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    private func getData(_ user: User) {
    //    guard let user = Auth.auth().currentUser else { return }
        DatabaseManager.shared.getUser(uid: user.uid) { (res) in
            switch res {
                case .success(let user):
                    self.currentUser = user
                    DatabaseManager.shared.getPostsFrom(path: "Favorites/\(user.id)") { [unowned self] (pictures) in
                        self.pictures.removeAll()
                        guard let pictures = pictures else { return }
                        self.pictures.append(contentsOf: pictures)
                    }
                    break
                case .failure(let err):
                    break
            }
        }
        
    }
    
    private func configureScrollView() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.pinViewTo(self.view)
        contentView.pinViewTo(scrollView)
        
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 600).isActive = true
    }
    
    private func setupViews() {
        let views = [headerView, firstItemPlaceHolder]
        headerView.backgroundColor = .systemBackground
        views.forEach { (view) in
            self.contentView.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
            view.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        }
        
        headerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        firstItemPlaceHolder.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16).isActive = true
        firstItemPlaceHolder.heightAnchor.constraint(equalToConstant: 152).isActive = true
        
        self.contentView.addSubview(favoritesLabel)
        favoritesLabel.topAnchor.constraint(equalTo: firstItemPlaceHolder.bottomAnchor, constant: 8).isActive = true
        favoritesLabel.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
    }
    
    private func setupChilds() {
        let headerVC = UserInfoHeaderViewController()
        guard let currentUser = currentUser else { return }
        headerVC.user = currentUser
        self.addChildVC(headerVC, at: self.headerView)
        let firstItemVC = UserExternalDetailsViewController()
        firstItemVC.delegate = self
        self.addChildVC(firstItemVC, at: self.firstItemPlaceHolder)
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.isScrollEnabled = true
        self.collectionView.backgroundColor = .init(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        self.collectionView.decelerationRate = .fast
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.collectionView.register(PopularCell.self, forCellWithReuseIdentifier: "favoriteCellId")
        
        self.contentView.addSubview(collectionView)
        self.collectionView.topAnchor.constraint(equalTo: self.favoritesLabel.bottomAnchor).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        let width = self.view.bounds.width / 2
        let height = width * 1.5
        self.collectionView.heightAnchor.constraint(equalToConstant: height).isActive = true
        self.collectionView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
            self.dismissAnimation()
        })
    }
    
    
    @objc private func selectAnimation() {
        let alert = UIAlertController(title: "Choose Animation Type", message: "", preferredStyle: .alert)
        let classic = UIAlertAction(title: "Classic Animation", style: .default, handler: { (action) -> Void in
            UserDefaults.standard.set(LoaderType.activity.rawValue, forKey: "loaderType")
        })
        
        let lottie = UIAlertAction(title: "Lottie Animation", style: .default, handler: { (action) -> Void in
            UserDefaults.standard.set(LoaderType.lottie.rawValue, forKey: "loaderType")
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
        
        let actions = [classic, lottie, cancel]
        actions.forEach({ alert.addAction($0) })
        self.present(alert, animated: true, completion: nil)
    }
}

extension UserViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCellId", for: indexPath) as? PopularCell else { return UICollectionViewCell() }
        cell.picture = pictures[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let picture = pictures[exist: indexPath.item]
        let vc = PictureDetailsViewController()
        vc.picture = picture
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2 - 32
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

extension UserViewController: Observable {
    func updateData(for user: User) {
        self.getData(user)
    }
}

extension UserViewController: BehanceDelegate {
    func didTapOnBehanceProfile() {
        guard let urlString = currentUser.userDetails.behanceURL else { return }
        guard let url = URL(string: urlString) else { return }
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .init(red: 86/255, green: 115/255, blue: 200/255, alpha: 1)
        self.present(safariVC, animated: true)
    }
}
