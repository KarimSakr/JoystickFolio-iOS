//
//  ProfileRouter.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 10/05/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import UIKit

protocol ProfileRouterDataPassing: AnyObject {
    var dataStore: ProfileDataStore? { get }
}

class ProfileRouter: ProfileRouterDataPassing{
    
    weak var viewController: ProfileViewController!
    var dataStore: ProfileDataStore?
    
    init(viewController: ProfileViewController,
         dataStore: ProfileDataStore){
        self.viewController = viewController
        self.dataStore = dataStore
    }
    
}
