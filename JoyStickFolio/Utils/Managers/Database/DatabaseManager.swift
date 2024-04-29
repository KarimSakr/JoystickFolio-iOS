//
//  DatabaseManager.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 25/01/2024.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import RxSwift

final class DatabaseManager {
    
    //MARK: - Cloud Database
    private let db = Firestore.firestore()
    
    //MARK: - Local Database
    private let persistence = Persistence.instance
    private let keychains = Keychains.shared

    //MARK: - saveIgdbInfo
    func saveIgdbInfo(igdb: IGDBAuth) throws {
        let expiryDate = calculateExpiryDate(expiresIn: igdb.expiresIn)
        
        persistence.save(expiryDate, key: Constants.Key.Persistence.expiryDate)
        
        do {
            try keychains.save(object: igdb.accessToken, key: Constants.Key.Persistence.accessToken)
        } catch {
            throw error
        }
    }
    
    //MARK: - fetchAccessToken
    func fetchAccessToken() throws -> (String, Double) {
        do {
            let accessToken = try keychains.getValue(key: Constants.Key.Persistence.accessToken)
            
            guard let expiryDate = persistence.getDouble(key: Constants.Key.Persistence.expiryDate) else {
                throw AppError.sessionExpired
            }
            return (accessToken, expiryDate)
        } catch {
            throw error
        }
    }
    
    //MARK: - Helper Functions
    
    //MARK: - calculateExpiryDate
    private func calculateExpiryDate(expiresIn: Int) -> TimeInterval {
        return Date().timeIntervalSince1970 + Double(expiresIn)
    }
}
