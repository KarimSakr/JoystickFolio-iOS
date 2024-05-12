//
//  EventsConfigurator.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 12/05/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class EventsConfigurator {
    static let shared = EventsConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: EventsViewController) {
        
        let presenter = EventsPresenter()
        
        let interactor = EventsInteractor()
        interactor.presenter = presenter
        
        let router = EventsRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
