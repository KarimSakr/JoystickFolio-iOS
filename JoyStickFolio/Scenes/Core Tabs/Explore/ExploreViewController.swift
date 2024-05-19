//
//  ExploreViewController.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 12/05/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import UIKit
import RxSwift

protocol ExploreViewControllerOutput {
    
}

class ExploreViewController: UIViewController {
    
    var interactor: ExploreViewControllerOutput?
    var router: ExploreRouter?
    
    lazy var searchController: UISearchController = {
       let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search..."
        return search
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        
        collectionView.register(GamePosterCollectionViewCell.self, forCellWithReuseIdentifier: GamePosterCollectionViewCell.identifier)
        
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
}

//MARK:- View Lifecycle
extension ExploreViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ExploreConfigurator.shared.configure(viewController: self)
        view.backgroundColor = .systemBackground
        navigationItem.searchController = searchController
        view.addSubview(collectionView)
        addBottomGradient(color: .purpleApp, alpha: 0.3)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 210),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}

//// MARK: Functions
//extension ExploreViewController {
//
//}
//
////MARK: - UISearchResultsUpdating
//extension ExploreViewController: UISearchResultsUpdating {
//
//    //MARK: - updateSearchResults
//    //TODO: Find a way to search on button pressed, not on character typing
//    func updateSearchResults(for searchController: UISearchController) {
//        guard let text = searchController.searchBar.text else { return }
//           print(text)
//    }
//}
//
////MARK: - UICollectionViewDelegate | UICollectionViewDelegate
//extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return viewModel.games.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GamePosterCollectionViewCell.identifier, for: indexPath) as? GamePosterCollectionViewCell else {
//            fatalError("Failed to dequeue GamePosterCollectionViewCell in HomeViewController")
//        }
//
//        cell.configure(with: viewModel.games[indexPath.item])
//        return cell
//    }
//}
//
////MARK: - UICollectionViewDelegateFlowLayout
//extension ExploreViewController: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: 140, height: 200)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 20
//    }
//}
//
