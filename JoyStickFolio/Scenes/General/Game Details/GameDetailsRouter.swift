//
//  GameDetailsRouter.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 02/06/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import UIKit

protocol GameDetailsRouterDataPassing: AnyObject {
    var dataStore: GameDetailsDataStore? { get }
}

class GameDetailsRouter: GameDetailsRouterDataPassing {
    
    weak var viewController: GameDetailsViewController!
    var dataStore: GameDetailsDataStore?
    
    init(viewController: GameDetailsViewController,
         dataStore: GameDetailsDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
    
}
