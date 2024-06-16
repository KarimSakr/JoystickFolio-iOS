//
//  ExplorePresenter.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 12/05/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import Foundation
import RxSwift

class ExplorePresenter {}

extension ExplorePresenter: ExploreInteractorOutput {
    
    func didGetGames(model: [GameAPI]) -> [ExploreModels.ViewModels.Game] {
        return model.map({self.createGame(model: $0)})
    }
    
    func didGetCovers(model: [CoverAPI]) -> [ExploreModels.ViewModels.Cover] {
        return model.map({self.createCover(model: $0)})
    }
    
}

//MARK: - Helper Functions -
extension ExplorePresenter {
    
    fileprivate
    func createGame(model: GameAPI) -> ExploreModels.ViewModels.Game {
        
        return ExploreModels.ViewModels.Game(cover: model.cover,
                                             name: model.name)
    }
    
    fileprivate
    func createCover(model: CoverAPI) -> ExploreModels.ViewModels.Cover {
        return ExploreModels.ViewModels.Cover(id: model.id, 
                                              url: model.url)
    }
}
