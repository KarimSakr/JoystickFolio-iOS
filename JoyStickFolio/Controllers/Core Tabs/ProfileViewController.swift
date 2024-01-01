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
        configureNavigationBar()
    }
    
    //MARK: - configureNavigationBar
    private func configureNavigationBar() {
        let hamburgerMenu = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .done, target: self, action: #selector(hamburgerMenuPressed))
        
        navigationItem.rightBarButtonItem = hamburgerMenu
    }
    
    //MARK: - hamburgerMenuPressed
    @objc private func hamburgerMenuPressed() {
        let vc = HamburgerMenuViewController()
        vc.title = "Settings"
        navigationController?.pushViewController(vc, animated: true)
    }
}
