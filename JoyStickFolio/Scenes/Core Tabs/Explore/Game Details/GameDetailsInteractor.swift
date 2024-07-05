//
//  GameDetailsInteractor.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 02/06/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

protocol GameDetailsInteractorOutput {
    
    func didGetGame(model: GameAPI, image: UIImage) -> GameDetailsModels.ViewModels.Game
    func didGetPlatforms(model: [PlatformAPI]) -> [GameDetailsModels.ViewModels.Platform]
    func didGetScreenshots(model: [ScreenshotAPI]) -> [GameDetailsModels.ViewModels.Screenshot]
    
}

protocol GameDetailsDataStore {
    var game: GameAPI { get set }
    var coverImage: UIImage { get set }
    
    var platforms: [PlatformAPI] { get set }
}

class GameDetailsInteractor: GameDetailsDataStore {
    
    var presenter: GameDetailsInteractorOutput?
    var game: GameAPI = GameAPI()
    var coverImage: UIImage = UIImage()
    var platforms: [PlatformAPI] = [PlatformAPI]()
}

extension GameDetailsInteractor: GameDetailsViewControllerOutput {
    
    func getGame() -> Single<GameDetailsModels.ViewModels.Game> {
        guard let presenter = presenter else {
            return Single<GameDetailsModels.ViewModels.Game>.error(AppError.genericAppError)
        }
        return Single<GameDetailsModels.ViewModels.Game>.just(presenter.didGetGame(model: game, image: coverImage))
    }
    
    func getPlatforms(platformIds: [Int]) -> Single<[GameDetailsModels.ViewModels.Platform]> {
        return Single<[GameDetailsModels.ViewModels.Platform]>
            .create { single in
                APIClient.shared.getPlatforms(platformsIds: platformIds)
                    .subscribe { [weak self] platforms in
                        guard let self = self else { return single(.failure(AppError.genericAppError)) }
                        guard let presenter = presenter else{ return single(.failure(AppError.genericAppError)) }
                        self.platforms = platforms
                        single(.success(presenter.didGetPlatforms(model: platforms)))
                    } onFailure: { [weak self] error in
                        guard self != nil else { return single(.failure(AppError.genericAppError)) }
                        single(.failure(error))
                    }
            }
    }
    
    func getScreenshots(screenshotsIds: [Int]) -> Single<[GameDetailsModels.ViewModels.Screenshot]> {
        return Single<[GameDetailsModels.ViewModels.Screenshot]>
            .create { single in
                APIClient.shared.getScreenshots(screenshorsIds: screenshotsIds)
                    .subscribe { [weak self] screenshots in
                        guard let self = self else { return single(.failure(AppError.genericAppError)) }
                        guard let presenter = presenter else{ return single(.failure(AppError.genericAppError)) }
                        single(.success(presenter.didGetScreenshots(model: screenshots)))
                    } onFailure: { [weak self] error in
                        guard self != nil else { return single(.failure(AppError.genericAppError)) }
                        single(.failure(error))
                    }
            }
    }
}
