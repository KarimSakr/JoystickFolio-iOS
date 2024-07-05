//
//  PlatformRouter.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 05/07/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import UIKit

protocol PlatformRouterDataPassing: AnyObject {
    var dataStore: PlatformDataStore? { get }
}

class PlatformRouter: PlatformRouterDataPassing {
    
    weak var viewController: PlatformViewController!
    var dataStore: PlatformDataStore?
    
    init(viewController: PlatformViewController,
         dataStore: PlatformDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
    
}
