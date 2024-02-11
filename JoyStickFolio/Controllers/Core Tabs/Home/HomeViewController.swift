//
//  HomeViewController.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 03/12/2023.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    //MARK: - View Models
    private let viewModel = HomeViewModel()
    
    //MARK: - AuthStateDidChangeListenerHandle
    var handle: AuthStateDidChangeListenerHandle?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        
        collectionView.register(GamePosterCollectionViewCell.self, forCellWithReuseIdentifier: GamePosterCollectionViewCell.identifier)
        
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        viewModel.fetchGames()
        
        configureNavigationBar()
    }
    
    //MARK: - viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.validateIgdb()
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleAuth()
    }
    
    //MARK: - viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
        
      Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    //MARK: - configureNavigationBar
    private func configureNavigationBar() {
        // Navigation Bar
        let messagesButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.message"), style: .done, target: self, action: #selector(messageButtonTapped))
        let notificationButton = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .done, target: self, action: #selector(notificationButtonTapped))
        
        navigationItem.rightBarButtonItems = [messagesButton, notificationButton]
    }
    
    //MARK: - messageButtonTapped
    @objc private func messageButtonTapped() {
        
    }
    
    //MARK: - notificationButtonTapped
    @objc private func notificationButtonTapped() {
        
    }
    
    //MARK: - handleAuth
    private func handleAuth() {
        
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            if auth.currentUser == nil {
                let loginVC = LoginViewController()
                loginVC.modalPresentationStyle = .fullScreen
                self.present(loginVC, animated: false)
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GamePosterCollectionViewCell.identifier, for: indexPath) as? GamePosterCollectionViewCell else {
            fatalError("Failed to dequeue GamePosterCollectionViewCell in HomeViewController")
        }
        
        cell.configure(with: viewModel.games[indexPath.row])
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = self.view.frame.width / 3
        return CGSize(width: size, height: size * 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
