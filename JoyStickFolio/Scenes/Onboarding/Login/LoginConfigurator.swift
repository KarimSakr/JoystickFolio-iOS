//
//  LoginConfigurator.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 06/05/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class LoginConfigurator {
    static let shared = LoginConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: LoginViewController) {
        
        let presenter = LoginPresenter()
        
        let interactor = LoginInteractor()
        interactor.presenter = presenter
        
        let router = LoginRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
