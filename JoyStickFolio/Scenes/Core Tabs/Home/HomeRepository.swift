//
//  HomeRepository.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 17/04/2024.

import RxSwift

protocol HomeRepositoryBusinessLogic {
    func twitchAuthentication() -> Observable<IGDBAuth>
    func saveIgdbInfo(igdb: IGDBAuth) throws
}

class HomeRepository: HomeRepositoryBusinessLogic {
    
    private let authenticationManager = AuthenticationManager()
    private let databaseManager = DatabaseManager()
    
    func twitchAuthentication() -> Observable<IGDBAuth> {
        return authenticationManager.twitchAuthentication()
    }
    
    func saveIgdbInfo(igdb: IGDBAuth) throws {
        
        try databaseManager.saveIgdbInfo(igdb: igdb)
        
    }
    
}
