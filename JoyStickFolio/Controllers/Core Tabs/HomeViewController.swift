//
//  HomeViewController.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 03/12/2023.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        handleAuth()
    }
    
    private func handleAuth() {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: false)
    }

}

