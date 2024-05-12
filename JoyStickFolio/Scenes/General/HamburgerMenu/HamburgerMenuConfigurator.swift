//
//  HamburgerMenuConfigurator.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 10/05/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class HamburgerMenuConfigurator {
    static let shared = HamburgerMenuConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: HamburgerMenuViewController) {
        
        let presenter = HamburgerMenuPresenter()
        
        let interactor = HamburgerMenuInteractor()
        interactor.presenter = presenter
        
        let router = HamburgerMenuRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
