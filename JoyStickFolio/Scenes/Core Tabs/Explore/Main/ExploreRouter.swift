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
    
    func goToDetailsVC(index: Int, coverImage: UIImage) {
        let vc = GameDetailsViewController()
        let game = dataStore!.games[index]
        vc.router?.dataStore?.game = game
        vc.router?.dataStore?.coverImage = coverImage
        viewController.navigationController?.pushViewController(vc, animated: true)
        
    }
}
