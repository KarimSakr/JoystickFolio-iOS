//
//  GameDetailsViewController.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 02/06/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import UIKit
import RxSwift

protocol GameDetailsViewControllerOutput {
    func getGame() -> Single<GameDetailsModels.ViewModels.Game>
}

class GameDetailsViewController: UIViewController {
    
    var interactor: GameDetailsViewControllerOutput?
    var router: GameDetailsRouter?

    var game: GameDetailsModels.ViewModels.Game!
    var platforms: [GameDetailsModels.ViewModels.Platform] = [GameDetailsModels.ViewModels.Platform]()
    
    private var bag = DisposeBag()
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    lazy var scrollStackViewContainer: UIStackView = {
        let container = UIStackView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.axis = .vertical
//        container.backgroundColor = .red
        return container
    }()
    
    
    lazy var headerView: UIView = {
        let header = UIView()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.backgroundColor = .gray.withAlphaComponent(0.5)
        return header
    }()
    
    lazy var headerPurpleRectangleView: UIView = {
        let rectangle = UIView()
        rectangle.backgroundColor = .purpleApp
        rectangle.translatesAutoresizingMaskIntoConstraints = false
        return rectangle
    }()
    
    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .title2), size: 25)
        return label
    }()
    
    lazy var whereToPlayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Where to play"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var platformCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(PlatformCollectionViewCell.self, forCellWithReuseIdentifier: PlatformCollectionViewCell.identifier)
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var gameInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Game info"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var gameDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem IpsumLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem IpsumLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem IpsumLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem IpsumLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"
        return label
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        GameDetailsConfigurator.shared.configure(viewController: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - View Lifecycle -
extension GameDetailsViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        addBottomGradient(color: .purpleApp, alpha: 0.3)
        self.addViews()
        self.getGame()
        self.setupDelegateAndDataSource()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([
            
            // scrollView constraints
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            // scrollViewContainer constraints
            scrollStackViewContainer.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            scrollStackViewContainer.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            scrollStackViewContainer.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            scrollStackViewContainer.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            scrollStackViewContainer.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            scrollStackViewContainer.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor),
            
            // header view
            headerView.topAnchor.constraint(equalTo: scrollStackViewContainer.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: scrollStackViewContainer.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: scrollStackViewContainer.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 250),
            
            // rectangle header view
            headerPurpleRectangleView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            headerPurpleRectangleView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            headerPurpleRectangleView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            headerPurpleRectangleView.heightAnchor.constraint(equalToConstant: 10),
            
            titleLabel.bottomAnchor.constraint(equalTo: headerPurpleRectangleView.topAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
            
            whereToPlayLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 30),
            whereToPlayLabel.leadingAnchor.constraint(equalTo: scrollStackViewContainer.leadingAnchor, constant: 10),
            
            platformCollectionView.topAnchor.constraint(equalTo: whereToPlayLabel.bottomAnchor, constant: 10),
            platformCollectionView.leadingAnchor.constraint(equalTo: scrollStackViewContainer.leadingAnchor),
            platformCollectionView.trailingAnchor.constraint(equalTo: scrollStackViewContainer.trailingAnchor),
            platformCollectionView.heightAnchor.constraint(equalToConstant: 50),
            
            gameInfoLabel.topAnchor.constraint(equalTo: platformCollectionView.bottomAnchor, constant: 30),
            gameInfoLabel.leadingAnchor.constraint(equalTo: scrollStackViewContainer.leadingAnchor, constant: 10),
            
            gameDescriptionLabel.topAnchor.constraint(equalTo: gameInfoLabel.bottomAnchor, constant: 10),
            gameDescriptionLabel.leadingAnchor.constraint(equalTo: scrollStackViewContainer.leadingAnchor, constant: 10),
            gameDescriptionLabel.trailingAnchor.constraint(equalTo: scrollStackViewContainer.trailingAnchor, constant: 10),
        ])
    }
    
}

//MARK: - UI -
extension GameDetailsViewController {
    
    fileprivate
    func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollStackViewContainer)
        
        scrollStackViewContainer.addSubview(headerView)
        headerView.addSubview(headerPurpleRectangleView)
        headerView.addSubview(titleLabel)
        scrollStackViewContainer.addSubview(whereToPlayLabel)
        scrollStackViewContainer.addSubview(platformCollectionView)
        scrollStackViewContainer.addSubview(gameInfoLabel)
        scrollStackViewContainer.addSubview(gameDescriptionLabel)
    }
}

//MARK: - Functions -
extension GameDetailsViewController {
    fileprivate
    func setupDelegateAndDataSource(){
        platformCollectionView.delegate = self
        platformCollectionView.dataSource = self
    }
}

//MARK: - Get Data -
extension GameDetailsViewController {
    fileprivate
    func getGame() {
        interactor!
            .getGame()
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] game in
                guard let self = self else { return }
                self.game = game
            } onFailure: { [weak self] error in
                guard let self = self else { return }
                self.showSnackBar(message: error.localizedDescription)
            }
            .disposed(by: bag)
    }
    
    fileprivate
    func updateUI() {
        
    }
}
//MARK: - UICollectionViewDelegate | UICollectionViewDelegate
extension GameDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlatformCollectionViewCell.identifier, for: indexPath) as! PlatformCollectionViewCell
        
        cell.configure(/*with: platforms[indexPath.item]*/)
        
        return cell
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension GameDetailsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 150, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
