//
//  ExploreConfigurator.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 12/05/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class ExploreConfigurator {
    static let shared = ExploreConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: ExploreViewController) {
        
        let presenter = ExplorePresenter()
        
        let interactor = ExploreInteractor()
        interactor.presenter = presenter
        
        let router = ExploreRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
