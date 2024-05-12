//
//  HomeRouter.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 08/05/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import UIKit

protocol HomeRouterDataPassing: AnyObject {
    var dataStore: HomeDataStore? { get }
}

class HomeRouter: HomeRouterDataPassing {
    
    weak var viewController: HomeViewController!
    var dataStore: HomeDataStore?
    
    init(viewController: HomeViewController,
         dataStore: HomeDataStore){
        self.viewController = viewController
        self.dataStore = dataStore
    }
    
    func presentLoginScreen() {
           guard let viewController = viewController else { return }
           let loginVC = LoginViewController()
           loginVC.modalPresentationStyle = .fullScreen
           viewController.present(loginVC, animated: false)
       }
    
}
