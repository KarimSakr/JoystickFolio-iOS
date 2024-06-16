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

    var game: GameAPI!
    
    private var bag = DisposeBag()
    
    //MARK: - scrollView
    lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = true
        scrollView.isScrollEnabled = true
        scrollView.bounces = true
        return scrollView
    }()
    
    lazy var scrollViewContainer: UIStackView = {
        let container = UIStackView()
        container.axis = .vertical
        container.translatesAutoresizingMaskIntoConstraints = false
        container.spacing = 0
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
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([
            
            // scrollView constraints
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            // scrollView constraints
            scrollViewContainer.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            scrollViewContainer.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor),
            
            // header view
            headerView.topAnchor.constraint(equalTo: scrollViewContainer.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 250),
            
            // rectangle header view
            headerPurpleRectangleView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            headerPurpleRectangleView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            headerPurpleRectangleView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            headerPurpleRectangleView.heightAnchor.constraint(equalToConstant: 10),
        ])
    }
    
}

//MARK: - UI -
extension GameDetailsViewController {
    
    fileprivate
    func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        
        scrollViewContainer.addArrangedSubview(headerView)
        headerView.addSubview(headerPurpleRectangleView)
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
                titleLabel.text = game.name ?? ""
            } onFailure: { [weak self] error in
                guard let self = self else { return }
                self.showSnackBar(message: error.localizedDescription)
            }
            .disposed(by: bag)
    }
}
