//
//  HamburgerMenuRouter.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 10/05/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import UIKit

protocol HamburgerMenuRouterDataPassing: AnyObject {
    var dataStore: HamburgerMenuDataStore? { get }
}

class HamburgerMenuRouter: HamburgerMenuRouterDataPassing{
    
    weak var viewController: HamburgerMenuViewController!
    var dataStore: HamburgerMenuDataStore?
    
    init(viewController: HamburgerMenuViewController,
         dataStore: HamburgerMenuDataStore){
        self.viewController = viewController
        self.dataStore = dataStore
    }
    
}
