//
//  ExploreViewController.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 19/04/2024.

import UIKit

protocol ExploreDisplayLogic: AnyObject {
    
}

class ExploreViewController: UIViewController, ExploreDisplayLogic {
    
    var interactor: ExploreBusinessLogic?
    var router: ExploreRouter?
    
    //MARK: - searchController
    lazy var searchController: UISearchController = {
       let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search..."
        return search
    }()
    
    //MARK: - collectionView
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        
        collectionView.register(GamePosterCollectionViewCell.self, forCellWithReuseIdentifier: GamePosterCollectionViewCell.identifier)
        
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    
}
// MARK: View lifecycle
extension ExploreViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
//        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 210),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
//        self.collectionView.dataSource = self
//        self.collectionView.delegate = self
        
//        viewModel.fetchGames() {
//            self.collectionView.reloadData()
//        }
        
        
    }
}

// MARK: Setup
extension ExploreViewController {
    
    private func setup() {
        let viewController = self
        let interactor = ExploreInteractor()
        let presenter = ExplorePresenter()
        let router = ExploreRouter()
        let repository = ExploreRepository()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.repository = repository
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
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
