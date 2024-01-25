//
//  HomeViewController.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 03/12/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        handleAuth()
    }
    
    private func configureNavigationBar() {
        // Navigation Bar
        let messagesButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.message"), style: .done, target: self, action: #selector(messageButtonTapped))
        let notificationButton = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .done, target: self, action: #selector(notificationButtonTapped))
        
        navigationItem.rightBarButtonItems = [messagesButton, notificationButton]
    }
    
    //MARK: - messageButtonTapped
    @objc private func messageButtonTapped() {
        
    }
    
    @objc private func notificationButtonTapped() {
        
    }
    
    //MARK: - handleAuth
    private func handleAuth() {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: false)
    }

}

