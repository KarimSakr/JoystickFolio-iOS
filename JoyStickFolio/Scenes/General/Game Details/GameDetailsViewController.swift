//
//  GameDetailsViewController.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 02/06/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import UIKit
import RxSwift
import SDWebImage

protocol GameDetailsViewControllerOutput {
    func getGame() -> Single<GameDetailsModels.ViewModels.Game>
    func getPlatforms(platformIds: [Int]) -> Single<[GameDetailsModels.ViewModels.Platform]>
    func getScreenshots(screenshotsIds: [Int]) -> Single<[GameDetailsModels.ViewModels.Screenshot]>
}

class GameDetailsViewController: BaseViewController {
    
    var interactor: GameDetailsViewControllerOutput?
    var router: GameDetailsRouter?

    var game: GameDetailsModels.ViewModels.Game?
    var platforms: [GameDetailsModels.ViewModels.Platform] = [GameDetailsModels.ViewModels.Platform]()
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.alwaysBounceVertical = true
        scroll.isUserInteractionEnabled = true
        scroll.showsVerticalScrollIndicator = false
        scroll.bounces = true
        return scroll
    }()
    
    lazy var containerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 10
        [headerView,
         whereToPlayContainerView,
         platformCollectionView,
         gameInfoContainerView].forEach { stack.addArrangedSubview($0) }
        return stack
    }()
    
    lazy var headerView: UIImageView = {
        let header = UIImageView()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.backgroundColor = .gray.withAlphaComponent(0.5)
        header.addBottomGradient(color: .black, alpha: 1)
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
        label.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .title2), size: 20)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var whereToPlayContainerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
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
        collectionView.isScrollEnabled = true
        return collectionView
    }()
    
    lazy var gameInfoContainerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
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
        label.textAlignment = .natural
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
        self.addViews()
        self.getGame()
        self.getScreenshots()
        self.setupDelegateAndDataSource()
    }
    
    fileprivate
    func addViews() {
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(containerView)
        
        containerView.addSubview(mainStack)
        
        headerView.addSubview(headerPurpleRectangleView)
        headerView.addSubview(titleLabel)
        
        whereToPlayContainerView.addSubview(whereToPlayLabel)
        
        gameInfoContainerView.addSubview(gameInfoLabel)
        gameInfoContainerView.addSubview(gameDescriptionLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([
            
            //ScrollView constraints
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            
            containerView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            //ScrollViewContainer constraints
            mainStack.topAnchor.constraint(equalTo: containerView.topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            mainStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            //Header view
            headerView.heightAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.56),
            
            headerPurpleRectangleView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            headerPurpleRectangleView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            headerPurpleRectangleView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            headerPurpleRectangleView.heightAnchor.constraint(equalToConstant: 10),
            
            titleLabel.bottomAnchor.constraint(equalTo: headerPurpleRectangleView.topAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            
            //Where to Play Container
            whereToPlayLabel.topAnchor.constraint(equalTo: whereToPlayContainerView.topAnchor),
            whereToPlayLabel.leadingAnchor.constraint(equalTo: whereToPlayContainerView.leadingAnchor, constant: 10),
            whereToPlayLabel.centerYAnchor.constraint(equalTo: whereToPlayContainerView.centerYAnchor),
            whereToPlayLabel.centerXAnchor.constraint(equalTo: whereToPlayContainerView.centerXAnchor),
            
            //Platform Collection View
            platformCollectionView.heightAnchor.constraint(equalToConstant: 50),
            
            //Game Info View
            gameInfoLabel.topAnchor.constraint(equalTo: gameInfoContainerView.topAnchor),
            gameInfoLabel.leadingAnchor.constraint(equalTo: gameInfoContainerView.leadingAnchor, constant: 10),
            gameInfoLabel.centerXAnchor.constraint(equalTo: gameInfoContainerView.centerXAnchor),

            gameDescriptionLabel.topAnchor.constraint(equalTo: gameInfoLabel.bottomAnchor, constant: 10),
            gameDescriptionLabel.leadingAnchor.constraint(equalTo: gameInfoContainerView.leadingAnchor, constant: 10),
            gameDescriptionLabel.bottomAnchor.constraint(equalTo: gameInfoContainerView.bottomAnchor, constant: -10),
            gameDescriptionLabel.centerXAnchor.constraint(equalTo: gameInfoContainerView.centerXAnchor),
        ])
        
        mainStack.setCustomSpacing(25, after: headerView)
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
                self.didGetgame()
                self.getPlatforms()
            } onFailure: { [weak self] error in
                guard let self = self else { return }
                self.showSnackBar(with: error.localizedDescription)
            }
            .disposed(by: bag)
    }
    
    fileprivate
    func getPlatforms() {
        guard let platforms = game?.platforms, !platforms.isEmpty else {
            self.didNotGetPlatforms()
            return
        }
        interactor!
            .getPlatforms(platformIds: game!.platforms ?? [])
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] platforms in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.platforms = platforms
                    self.platformCollectionView.reloadData()
                }
            } onFailure: { [weak self] error in
                guard let self = self else { return }
                self.showSnackBar(with: error.localizedDescription)
            }
            .disposed(by: bag)
    }
    
    fileprivate
    func getScreenshots() {
        guard let screenshotIds = game?.screenshots, !screenshotIds.isEmpty else {
            return
        }
        interactor!
            .getScreenshots(screenshotsIds: screenshotIds)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] screenshots in
                guard let self = self else { return }
                self.updateImage(with: screenshots.randomItem()!)
            } onFailure: { [weak self] error in
                guard let self = self else { return }
                self.showSnackBar(with: error.localizedDescription)
            }
            .disposed(by: bag)
    }
    
}

//MARK: - UI -
extension GameDetailsViewController {
    fileprivate
    func didGetgame() {
        titleLabel.text = game?.name
        gameDescriptionLabel.text = game?.summary
    }
    
    fileprivate
    func didNotGetPlatforms() {
        self.platforms = [GameDetailsModels.ViewModels.Platform(name: "No platforms")]
    }
    
    fileprivate
    func updateImage(with screenshot: GameDetailsModels.ViewModels.Screenshot) {
        guard let screenshotUrl = screenshot.url else { return }
        headerView.sd_setImage(with: URL(string: "https:" + screenshotUrl), placeholderImage: UIImage(named: "JoystickFolioLogo.png"))
    }
}
//MARK: - UICollectionViewDelegate | UICollectionViewDelegate
extension GameDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return platforms.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlatformCollectionViewCell.identifier, for: indexPath) as! PlatformCollectionViewCell
        
        cell.configure(platform: platforms[indexPath.item])
        
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
