//
//  HomeViewController.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 08/05/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import UIKit
import RxSwift
import FirebaseAuth

protocol HomeViewControllerOutput {
    func validateIgdb() -> Single<Void>
}

class HomeViewController: BaseViewController {
    
    var interactor: HomeViewControllerOutput?
    var router: HomeRouter?
    var handle: AuthStateDidChangeListenerHandle?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        HomeConfigurator.shared.configure(viewController: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - View Lifecycle -
extension HomeViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        validateIgdb()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleAuth()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      Auth.auth().removeStateDidChangeListener(handle!)
    }
}

//MARK: - functions -
extension HomeViewController {
    
     @objc private func messageButtonTapped() {
         
     }
     
     @objc private func notificationButtonTapped() {
         
     }
}

//MARK: - setup -
extension HomeViewController {
    
    func validateIgdb() {
        guard let interactor = interactor else { return }
        interactor.validateIgdb()
            .observe(on: MainScheduler.instance)
            .subscribe(onFailure: { [weak self] error in
                guard let self = self else { return }
                self.showSnackBar(with: "Something went wrong: \n\(error.localizedDescription)")
            })
            .disposed(by: self.bag)

    }
    
    private func handleAuth() {
        guard let router = router else { return }
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            if auth.currentUser == nil {
                 router.presentLoginScreen()
            }
        }
    }
    
    private func configureNavigationBar() {
        // Navigation Bar
        let messagesButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.message"), style: .done, target: self, action: #selector(messageButtonTapped))
        let notificationButton = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .done, target: self, action: #selector(notificationButtonTapped))
        
        navigationItem.rightBarButtonItems = [messagesButton, notificationButton]
    }
}
