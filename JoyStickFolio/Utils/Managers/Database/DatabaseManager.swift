//
//  DatabaseManager.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 25/01/2024.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

final class DatabaseManager {
    
    private let db = Firestore.firestore()
    
    private let persistence = Persistence.instance
    private let keychains = Keychains.shared
    
    //MARK: - isUsernameAvailable
    func isUsernameAvailable(username: String) async -> Bool {
        let ref = db.collection(Constants.Firebase.FireStore.Collection.users).document(username)
        do {
            let document = try await ref.getDocument()
            if document.exists {
                return false
            } else {
                return true
            }
        } catch {
            return false
        }
    }
    
    //MARK: - fetchEmail
    func fetchEmail(of username: String) async throws -> String {
        
        do {
            let query = try await db
                .collection(Constants.Firebase.FireStore.Collection.users)
                .whereField(Constants.Key.Auth.username, isEqualTo: username)
                .getDocuments()
            
            for document in query.documents {
                
                if document.exists {
                    
                    let data = document.data()
                    return data[Constants.Key.Auth.email] as! String
                } else {
                    
                    throw AppError.wrongCredentials
                }
            }
            throw AppError.wrongCredentials
        } catch {
            throw error
        }
    }
    
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
