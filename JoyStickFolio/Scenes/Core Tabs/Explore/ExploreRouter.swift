//
//  ExploreRouter.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 12/05/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import UIKit

protocol ExploreRouterDataPassing: AnyObject {
    var dataStore: ExploreDataStore? { get }
}

class ExploreRouter: ExploreRouterDataPassing {
    
    weak var viewController: ExploreViewController!
    var dataStore: ExploreDataStore?
    
    init(viewController: ExploreViewController,
         dataStore: ExploreDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
    
}
