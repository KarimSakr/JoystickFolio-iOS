//
//  ProfileViewController.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 30/12/2023.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation Bar
        let messagesButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .done, target: self, action: #selector(hamburgerMenuPressed))
        
        navigationItem.rightBarButtonItem = messagesButton
    }
    
    @objc private func hamburgerMenuPressed() {
        let vc = HamburgerMenuViewController()
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
}
