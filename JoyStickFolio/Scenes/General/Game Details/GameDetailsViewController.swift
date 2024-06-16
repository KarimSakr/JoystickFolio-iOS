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
extension GameDetailsViewController{
        
    override func viewDidLoad() {
        super.viewDidLoad()
        addBottomGradient(color: .purpleApp, alpha: 0.3)
        getData()
        view.addSubview(titleLabel)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            titleLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
    
}

//MARK: - Get Data -
extension GameDetailsViewController {
    fileprivate
    func getData() {
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
