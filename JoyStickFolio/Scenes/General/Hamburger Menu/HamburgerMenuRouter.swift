//
//  HamburgerMenuRouter.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 17/04/2024.


import UIKit

@objc protocol HamburgerMenuRoutingLogic {
    
}

protocol HamburgerMenuDataPassing {
    var dataStore: HamburgerMenuDataStore? { get }
}

class HamburgerMenuRouter: NSObject, HamburgerMenuRoutingLogic, HamburgerMenuDataPassing {
    weak var viewController: HamburgerMenuViewController?
    var dataStore: HamburgerMenuDataStore?
    
}
