//
//  HomeInteractor.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 08/05/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import Foundation
import RxSwift

protocol HomeInteractorOutput {
    
}

protocol HomeDataStore {
    
}

class HomeInteractor: HomeDataStore{
    
    var presenter: HomeInteractorOutput?
    private var disposeBag = DisposeBag()
    
}

extension HomeInteractor: HomeViewControllerOutput{
    
    func validateIgdb() -> Single<Void> {
        
        return Single<Void>
            .create { single in
                
                if !self.isAccessTokenValid() {
                    
                    APIClient.shared
                        .twitchAuth()
                        .subscribe { [weak self] igdbAuth in
                            guard let self = self else { return }
                            do{
                                try self.saveIgdbInfo(igdb: igdbAuth)
                                single(.success(()))
                            } catch {
                                single(.failure(error))
                            }
                            
                        } onFailure: { error in
                            single(.failure(error))
                        }
                        .disposed(by: self.disposeBag)
                    
                }
                return Disposables.create()
            }
        
    }
    
    private func isAccessTokenValid() -> Bool {
           do {
               let (token, expiryDate) = try fetchAccessToken()
   
               guard !token.isEmpty, expiryDate > Date().timeIntervalSince1970 else {
                   return false
               }
               return true
           } catch  {
               return false
           }
   
       }
}

//MARK: - Helper functions -
extension HomeInteractor {
    fileprivate
    func fetchAccessToken() throws -> (String, Double) {
        do {
            let accessToken = try Keychains.shared.getValue(key: Constants.Key.Persistence.accessToken)
            
            guard let expiryDate = Persistence.instance.getDouble(key: Constants.Key.Persistence.expiryDate) else {
                throw AppError.sessionExpired
            }
            return (accessToken, expiryDate)
        } catch {
            throw error
        }
    }
    
    fileprivate
    func saveIgdbInfo(igdb: IGDBAuth) throws {
        let expiryDate = calculateExpiryDate(expiresIn: igdb.expiresIn)
        
        Persistence.instance.save(expiryDate, key: Constants.Key.Persistence.expiryDate)
        
        do {
            try Keychains.shared.save(object: igdb.accessToken, key: Constants.Key.Persistence.accessToken)
        } catch {
            throw error
        }
    }
    
    fileprivate
    func calculateExpiryDate(expiresIn: Int) -> TimeInterval {
        return Date().timeIntervalSince1970 + Double(expiresIn)
    }
}
