//
//  ThreadsRouter.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 12/05/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import UIKit

protocol ThreadsRouterDataPassing: AnyObject {
    var dataStore: ThreadsDataStore? { get }
}

class ThreadsRouter: ThreadsRouterDataPassing {
    
    weak var viewController: ThreadsViewController!
    var dataStore: ThreadsDataStore?
    
    init(viewController: ThreadsViewController,
         dataStore: ThreadsDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
    
}
