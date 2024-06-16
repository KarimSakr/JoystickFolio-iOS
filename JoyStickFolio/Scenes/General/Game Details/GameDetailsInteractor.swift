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
    
}

protocol GameDetailsDataStore {
    var game: GameAPI { get set }
    var coverImage: UIImage { get set }
}

class GameDetailsInteractor: GameDetailsDataStore {
    
    var presenter: GameDetailsInteractorOutput?
    var game: GameAPI = GameAPI()
    var coverImage: UIImage = UIImage()
}

extension GameDetailsInteractor: GameDetailsViewControllerOutput {
    
    func getGame() -> Single<GameDetailsModels.ViewModels.Game> {
        guard let presenter = presenter else {
            return Single<GameDetailsModels.ViewModels.Game>.error(AppError.genericAppError)
        }
        return Single<GameDetailsModels.ViewModels.Game>.just(presenter.didGetGame(model: game, image: coverImage))
    }
    
    
}
