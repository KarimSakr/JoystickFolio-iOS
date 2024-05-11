//
//  ProfileViewController.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 10/05/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import UIKit
import RxSwift

protocol ProfileViewControllerOutput {
    
}

class ProfileViewController: UIViewController {
    
    var interactor: ProfileViewControllerOutput?
    var router: ProfileRouter?
    
    
    
}

//MARK: - View Lifecycle -
extension ProfileViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ProfileConfigurator.shared.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}

extension ProfileViewController {
    
    private func configureNavigationBar() {
        let hamburgerMenu = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .done, target: self, action: #selector(hamburgerMenuPressed))
        
        navigationItem.rightBarButtonItem = hamburgerMenu
    }
    // add router
    @objc private func hamburgerMenuPressed() {
        let vc = HamburgerMenuViewController()
        vc.title = "Settings"
        navigationController?.pushViewController(vc, animated: true)
    }
}
