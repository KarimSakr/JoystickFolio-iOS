//
//  HomeInteractor.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 17/04/2024.

import UIKit
import RxSwift

protocol HomeBusinessLogic {
    func validateIgdb()
}

protocol HomeDataStore {
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    var presenter: HomePresentationLogic?
    var repository: HomeRepositoryBusinessLogic?
    
    private let authenticationManager = AuthenticationManager()
    private let databaseManager = DatabaseManager()
    private var bag = DisposeBag()
    
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
