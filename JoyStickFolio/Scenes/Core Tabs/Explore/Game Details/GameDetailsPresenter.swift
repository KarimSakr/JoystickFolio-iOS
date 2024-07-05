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
                                                 gameLocalizations: model.gameLocalizations,
                                                 image: image)
    }
    
    func didGetPlatforms(model: [PlatformAPI]) -> [GameDetailsModels.ViewModels.Platform] {
        return model.map({self.createSinglePlatform(model: $0)})
    }
    
    func didGetScreenshots(model: [ScreenshotAPI]) -> [GameDetailsModels.ViewModels.Screenshot] {
        return model.map({self.createSingleScreenshot(model: $0)})
    }
}

//MARK: - Helper Functions -
extension GameDetailsPresenter {
    fileprivate 
    func createSinglePlatform(model: PlatformAPI) -> GameDetailsModels.ViewModels.Platform {
        return GameDetailsModels.ViewModels.Platform(id: model.id,
                                                     abbreviation: model.abbreviation,
                                                     category: model.category,
                                                     createdAt: model.createdAt,
                                                     name: model.name,
                                                     platformLogo: model.platformLogo,
                                                     slug: model.slug,
                                                     updatedAt: model.updatedAt,
                                                     url: model.url,
                                                     versions: model.versions,
                                                     checksum: model.checksum)
    }
    
    fileprivate
    func createSingleScreenshot(model: ScreenshotAPI) -> GameDetailsModels.ViewModels.Screenshot {
        return GameDetailsModels.ViewModels.Screenshot(id: model.id,
                                                       game: model.game,
                                                       height: model.height,
                                                       imageId: model.imageId,
                                                       url: model.url,
                                                       width: model.width,
                                                       checksum: model.checksum)
    }
}
