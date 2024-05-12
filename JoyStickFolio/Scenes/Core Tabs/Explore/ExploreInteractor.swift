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
    
    
}

protocol ExploreDataStore {
    
}

class ExploreInteractor: ExploreDataStore {
    
    var presenter: ExploreInteractorOutput?
    
}

extension ExploreInteractor: ExploreViewControllerOutput {
    
    
    ////MARK: - Managers
    //private let databaseManager = DatabaseManager()
    //
    ////MARK: - bag
    //private let bag = DisposeBag()
    //
    ////MARK: - games
    //var games = [Game]()
    //
    ////MARK: - fetchGames
    //func fetchGames(completion: @escaping () -> Void) {
    //    databaseManager
    //        .fetchGames()
    //        .subscribe(onNext: { games in
    //            self.games = games
    //            completion()
    //        })
    //        .disposed(by: bag)
    //}
    
}
