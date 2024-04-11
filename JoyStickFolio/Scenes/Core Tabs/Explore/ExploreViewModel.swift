//
//  ExploreViewModel.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 13/02/2024.
//

import Foundation
import RxSwift

final class ExploreViewModel {
    
    //MARK: - Managers
    private let databaseManager = DatabaseManager()
    
    //MARK: - bag
    private let bag = DisposeBag()
    
    //MARK: - games
    var games = [Game]()
    
    //MARK: - fetchGames
    func fetchGames(completion: @escaping () -> Void) {
        databaseManager
            .fetchGames()
            .subscribe(onNext: { games in
                self.games = games
                completion()
            })
            .disposed(by: bag)
    }
    
}
