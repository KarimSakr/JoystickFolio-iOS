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
        
        return ExploreModels.ViewModels.Game(id: model.id,
                                             ageRatings: model.ageRatings,
                                             alternativeNames: model.alternativeNames,
                                             category: model.category,
                                             cover: model.cover,
                                             createdAt: model.createdAt,
                                             externalGames: model.externalGames,
                                             firstReleaseDate: model.firstReleaseDate,
                                             gameModes: model.gameModes,
                                             genres: model.genres,
                                             involvedCompanies: model.involvedCompanies,
                                             keywords: model.keywords,
                                             name: model.name,
                                             platforms: model.platforms,
                                             playerPerspectives: model.playerPerspectives,
                                             releaseDates: model.releaseDates,
                                             screenshots: model.screenshots,
                                             similarGames: model.similarGames,
                                             slug: model.slug,
                                             storyline: model.storyline,
                                             summary: model.summary,
                                             tags: model.tags,
                                             themes: model.themes,
                                             updatedAt: model.updatedAt,
                                             url: model.url,
                                             videos: model.videos,
                                             websites: model.websites,
                                             checksum: model.checksum,
                                             gameLocalizations: model.gameLocalizations)
    }
    
    fileprivate
    func createCover(model: CoverAPI) -> ExploreModels.ViewModels.Cover {
        return ExploreModels.ViewModels.Cover(id: model.id, 
                                              url: model.url)
    }
}
