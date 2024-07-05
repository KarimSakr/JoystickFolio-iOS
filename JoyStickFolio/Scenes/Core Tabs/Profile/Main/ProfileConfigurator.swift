//
//  ProfileConfigurator.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 10/05/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class ProfileConfigurator {
    static let shared = ProfileConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: ProfileViewController) {
        
        let presenter = ProfilePresenter()
        
        let interactor = ProfileInteractor()
        interactor.presenter = presenter
        
        let router = ProfileRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
