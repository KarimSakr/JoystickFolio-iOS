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
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
       
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
