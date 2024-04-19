//
//  ExploreInteractor.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 19/04/2024.

import UIKit

protocol ExploreBusinessLogic {
    
}

protocol ExploreDataStore {
}

class ExploreInteractor: ExploreBusinessLogic, ExploreDataStore {
    var presenter: ExplorePresentationLogic?
    var repository: ExploreRepositoryBusinessLogic?
    
    
}

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
