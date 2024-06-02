//
//  ExploreInteractor.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 12/05/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import Foundation
import RxSwift

protocol ExploreInteractorOutput {
    
    func didGetGames(model: [GameAPI]) -> [ExploreModels.ViewModels.Game]
    func didGetCovers(model: [CoverAPI]) -> [ExploreModels.ViewModels.Cover]
    
}

protocol ExploreDataStore {
    var games: [GameAPI] { get set}
}

class ExploreInteractor: ExploreDataStore {
    
    var presenter: ExploreInteractorOutput?
    var games: [GameAPI] = [GameAPI]()
}

extension ExploreInteractor: ExploreViewControllerOutput {
    
    
    //MARK: - getGames
    func getGames(offset: Int) -> Single<[ExploreModels.ViewModels.Game]> {
        return Single<[ExploreModels.ViewModels.Game]>
            .create { single in
                APIClient.shared.getGames(offset: offset)
                    .subscribe(onSuccess: { [weak self] games in
                        guard let self = self else { return single(.failure(AppError.genericAppError)) }
                        guard let presenter = presenter else{ return single(.failure(AppError.genericAppError)) }
                        self.games = games
                        single(.success(presenter.didGetGames(model: games)))
                    }, onFailure: { [weak self] error in
                        guard let self = self else { return single(.failure(AppError.genericAppError))}
                        single(.failure(error))
                    })
            }
    }
    
    func getCovers(gameIds: [Int]) -> Single<[ExploreModels.ViewModels.Cover]> {
        return Single<[ExploreModels.ViewModels.Cover]>
            .create { single in
                APIClient.shared.getCovers(gameIds: gameIds)
                    .subscribe(onSuccess: { [weak self] covers in
                        guard let self = self else { return single(.failure(AppError.genericAppError)) }
                        guard let presenter = presenter else { return single(.failure(AppError.genericAppError)) }
                        single(.success(presenter.didGetCovers(model: covers)))
                    }, onFailure: { [weak self] error in
                        guard let self = self else { return single(.failure(AppError.genericAppError))}
                        single(.failure(error))
                    })
            }
    }
}
