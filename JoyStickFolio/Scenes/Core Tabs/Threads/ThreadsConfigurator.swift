//
//  ThreadsConfigurator.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 12/05/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class ThreadsConfigurator {
    static let shared = ThreadsConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: ThreadsViewController) {
        
        let presenter = ThreadsPresenter()
        
        let interactor = ThreadsInteractor()
        interactor.presenter = presenter
        
        let router = ThreadsRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
