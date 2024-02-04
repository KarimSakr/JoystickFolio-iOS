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
}
