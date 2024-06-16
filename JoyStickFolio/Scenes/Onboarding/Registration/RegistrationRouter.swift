//
//  RegistrationRouter.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 11/05/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import UIKit

protocol RegistrationRouterDataPassing: AnyObject {
    var dataStore: RegistrationDataStore? { get }
}

class RegistrationRouter: RegistrationRouterDataPassing {
    
    weak var viewController: RegistrationViewController!
    var dataStore: RegistrationDataStore?
    
    init(viewController: RegistrationViewController,
         dataStore: RegistrationDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
    
}
