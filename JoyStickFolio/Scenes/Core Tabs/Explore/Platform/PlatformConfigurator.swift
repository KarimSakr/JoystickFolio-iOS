//
//  PlatformConfigurator.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 05/07/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class PlatformConfigurator {
    static let shared = PlatformConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: PlatformViewController) {
        
        let presenter = PlatformPresenter()
        
        let interactor = PlatformInteractor()
        interactor.presenter = presenter
        
        let router = PlatformRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
