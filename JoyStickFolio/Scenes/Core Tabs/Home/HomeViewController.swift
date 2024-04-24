//
//  HomeViewController.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 17/04/2024.

import UIKit
import FirebaseAuth

protocol HomeDisplayLogic: AnyObject {
    
}

class HomeViewController: UIViewController, HomeDisplayLogic {
    
    var interactor: HomeBusinessLogic?
    var router: HomeRouter?
    
    
    var handle: AuthStateDidChangeListenerHandle?
    
}

//MARK: - View Lifecycle
extension HomeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureNavigationBar()
        validateIgdb()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleAuth()
    }
    
    //MARK: - viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
        
      Auth.auth().removeStateDidChangeListener(handle!)
    }
}

//MARK: - functions
extension HomeViewController {
    
    func validateIgdb() {
        guard let interactor = interactor else { return }
        interactor.validateIgdb()
    }
    
     
     @objc private func messageButtonTapped() {
         
     }
     
     //MARK: - notificationButtonTapped
     @objc private func notificationButtonTapped() {
         
     }
     
     //MARK: - handleAuth
     private func handleAuth() {
         guard let router = router else { return }
         handle = Auth.auth().addStateDidChangeListener { auth, user in
             if auth.currentUser == nil {
                 router.presentLoginScreen()
             }
         }
     }
}

//MARK: - setup
extension HomeViewController {
    
    private func setup() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        let repository = HomeRepository()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.repository = repository
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func configureNavigationBar() {
        // Navigation Bar
        let messagesButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.message"), style: .done, target: self, action: #selector(messageButtonTapped))
        let notificationButton = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .done, target: self, action: #selector(notificationButtonTapped))
        
        navigationItem.rightBarButtonItems = [messagesButton, notificationButton]
    }
}
