//
//  GameDetailsPresenter.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 02/06/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

class GameDetailsPresenter {}

extension GameDetailsPresenter: GameDetailsInteractorOutput {
    
    func didGetGame(model: GameAPI, image: UIImage) -> GameDetailsModels.ViewModels.Game {
        return GameDetailsModels.ViewModels.Game(id: model.id,
                                                 ageRatings: model.ageRatings,
                                                 artworks: model.artworks,
                                                 category: model.category,
                                                 cover: model.cover,
                                                 createdAt: model.createdAt,
                                                 externalGames: model.externalGames,
                                                 firstReleaseDate: model.firstReleaseDate,
                                                 gameModes: model.gameModes,
                                                 genres: model.genres,
                                                 name: model.name,
                                                 platforms: model.platforms,
                                                 releaseDates: model.releaseDates,
                                                 screenshots: model.screenshots,
                                                 similarGames: model.similarGames,
                                                 slug: model.slug,
                                                 summary: model.summary,
                                                 tags: model.tags,
                                                 updatedAt: model.updatedAt,
                                                 url: model.url,
                                                 versionParent: model.versionParent,
                                                 versionTitle: model.versionTitle,
                                                 checksum: model.checksum,
                                                 image: image)
    }
    
    
}
