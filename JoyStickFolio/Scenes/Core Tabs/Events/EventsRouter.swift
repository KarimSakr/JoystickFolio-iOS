//
//  EventsRouter.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 12/05/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import UIKit

protocol EventsRouterDataPassing: AnyObject {
    var dataStore: EventsDataStore? { get }
}

class EventsRouter: EventsRouterDataPassing {
    
    weak var viewController: EventsViewController!
    var dataStore: EventsDataStore?
    
    init(viewController: EventsViewController,
         dataStore: EventsDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
    
}
