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
    
    func createUserProfile(newUser: CreatedUserProfile, userId: String, completion: @escaping (Error?) -> Void) throws {
        do{
            try sendData(to: Constants.Firebase.FireStore.Collection.users, data: newUser, docId: userId) { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        } catch {
            throw error
        }
    }
    
    //MARK: - sendData
    private func sendData<T: Encodable>(to collection: String, data: T, docId: String, completion: @escaping (Error?) -> Void) throws {
        do {
            try db.collection(collection).document(docId).setData(from: data) { error in
                completion(error)
            }
        } catch {
            throw error
        }
    }
    
    private func fetchData<T: Decodable>(from colleciton: String, docId: String, withModel: T.Type) async throws -> T {
        do {
            return try await db.collection(colleciton).document(docId).getDocument(as: T.self)
        } catch {
            throw error
        }
    }
}
