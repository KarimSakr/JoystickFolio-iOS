//
//  HomeConfigurator.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 08/05/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class HomeConfigurator {
    static let shared = HomeConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: HomeViewController) {
        
        let presenter = HomePresenter()
        
        let interactor = HomeInteractor()
        interactor.presenter = presenter
        
        let router = HomeRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
