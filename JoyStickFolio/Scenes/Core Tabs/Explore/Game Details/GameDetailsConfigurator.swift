//
//  GameDetailsConfigurator.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 02/06/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class GameDetailsConfigurator {
    static let shared = GameDetailsConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: GameDetailsViewController) {
        
        let presenter = GameDetailsPresenter()
        
        let interactor = GameDetailsInteractor()
        interactor.presenter = presenter
        
        let router = GameDetailsRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
