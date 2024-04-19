//
//  ExploreRouter.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 19/04/2024.


import UIKit

@objc protocol ExploreRoutingLogic {
    
}

protocol ExploreDataPassing {
    var dataStore: ExploreDataStore? { get }
}

class ExploreRouter: NSObject, ExploreRoutingLogic, ExploreDataPassing {
    weak var viewController: ExploreViewController?
    var dataStore: ExploreDataStore?
    
}
