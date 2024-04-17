//
//  HomeRouter.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 17/04/2024.


import UIKit

@objc protocol HomeRoutingLogic {
    func presentLoginScreen()
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing {
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
    
    func presentLoginScreen() {
        guard let viewController = viewController else { return }
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        viewController.present(loginVC, animated: false)
    }
}
