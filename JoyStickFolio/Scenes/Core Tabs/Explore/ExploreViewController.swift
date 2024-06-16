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
    func getGames(offset: Int) -> Single<[ExploreModels.ViewModels.Game]>
    func getCovers(gameIds: [Int]) -> Single<[ExploreModels.ViewModels.Cover]>
}

class ExploreViewController: UIViewController {
    
    var interactor: ExploreViewControllerOutput?
    var router: ExploreRouter?
    
    fileprivate
    var bag = DisposeBag()
    
    fileprivate
    var games: [ExploreModels.ViewModels.Game] = [ExploreModels.ViewModels.Game]()
    
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
    
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        ExploreConfigurator.shared.configure(viewController: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - View Lifecycle -
extension ExploreViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBottomGradient(color: .purpleApp, alpha: 0.3)
        collectionView.delegate = self
        collectionView.dataSource = self
        navigationItem.searchController = searchController
        view.addSubview(collectionView)
        getGames()
        view.backgroundColor = .systemBackground
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

//MARK: - UISearchResultsUpdating
extension ExploreViewController: UISearchResultsUpdating {

    //MARK: - updateSearchResults
    //TODO: Find a way to search on button pressed, not on character typing
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
           print(text)
    }
}

//MARK: - UICollectionViewDelegate | UICollectionViewDelegate
extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GamePosterCollectionViewCell.identifier, for: indexPath) as? GamePosterCollectionViewCell else {
            fatalError("Failed to dequeue GamePosterCollectionViewCell in HomeViewController")
        }

        cell.configure(with: games[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! GamePosterCollectionViewCell
        router?.goToDetailsVC(index: indexPath.item, coverImage: cell.imagePoster.image ?? UIImage())
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ExploreViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 140, height: 200)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

//MARK: - Functions -
extension ExploreViewController {
    fileprivate
    func reloadData() {
        collectionView.reloadData()
    }
}


//MARK: - Fetch Data -
extension ExploreViewController {
    
    fileprivate
    func getGames() {
        interactor!
            .getGames(offset: 0)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] games in
                guard let self = self else { return }
                self.games.append(contentsOf: games)
                self.reloadData()
                self.getCovers()
            }, onFailure: {[weak self] error in
                guard let self = self else { return }
                self.showSnackBar(message: error.localizedDescription)
            }).disposed(by: bag)
    }
    
    fileprivate
    func getCovers() {
        interactor!
            .getCovers(gameIds: self.games.compactMap({$0.cover}))
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] covers in
                guard let self = self else { return }
                for (index, _) in covers.enumerated() {
                    self.games[index].imageUrl = covers.filter({$0.id == self.games[index].cover}).first?.url
                }
                self.reloadData()
            }, onFailure: { [weak self] error in
                guard let self = self else { return }
                self.showSnackBar(message: error.localizedDescription)
            }).disposed(by: bag)
    }
}

