//
//  HomeViewModel.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 10/02/2024.
//

import Foundation
import FirebaseAuth 
import RxSwift

final class HomeViewModel {
    
    //MARK: - bag
    private let bag = DisposeBag()
    
    var games = [Game]()
    
    //MARK: - Managers
    private let authenticationManager = AuthenticationManager()
    private let databaseManager = DatabaseManager()
    
    //MARK: - validateIgdb
    func validateIgdb() {
        if !isAccessTokenValid() {
            authenticationManager.twitchAuthentication()
                .subscribe( onError: { error in
                    // handle error
                }, onCompleted: {
                    // handle completion
                })
                .disposed(by: bag)
        }
    }
    
    func fetchGames() {
        databaseManager
            .fetchGames()
            .subscribe(onNext: { games in
                self.games = games
            })
            .disposed(by: bag)
    }
    
    //MARK: - Helper Functions
    //MARK: - isAccessTokenValid
    private func isAccessTokenValid() -> Bool {
        do {
            let (token, expiryDate) = try databaseManager.fetchAccessToken()
            
            guard !token.isEmpty, expiryDate > Date().timeIntervalSince1970 else {
                return false
            }
            return true
        } catch  {
            return false
        }
        
    }
}
