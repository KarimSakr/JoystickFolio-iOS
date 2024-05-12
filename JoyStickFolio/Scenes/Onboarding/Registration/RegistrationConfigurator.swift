//
//  RegistrationConfigurator.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 11/05/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class RegistrationConfigurator {
    static let shared = RegistrationConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: RegistrationViewController) {
        
        let presenter = RegistrationPresenter()
        
        let interactor = RegistrationInteractor()
        interactor.presenter = presenter
        
        let router = RegistrationRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
