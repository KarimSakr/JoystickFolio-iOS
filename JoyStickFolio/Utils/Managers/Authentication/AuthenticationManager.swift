//
//  AuthenticationManager.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 25/01/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseCore
import RxSwift

final class AuthenticationManager {
    
    //MARK: - Managers
    private let databaseManager = DatabaseManager()
    
    private let db = Firestore.firestore()
    
    func createUser(with userInfo: [String : String]) async -> Observable<Void> {
        
        do {
            guard await self.isUsernameAvailable(username: userInfo[Constants.Key.Auth.username]!) else {
                return Observable.error(AppError.usernameTaken)
            }
            try await Auth.auth()
                .createUser(withEmail: userInfo[Constants.Key.Auth.email]!, password: userInfo[Constants.Key.Auth.password]!)
            
            let newUser = CreatedUserProfile(email   : userInfo[Constants.Key.Auth.email]!,
                                             fullName: userInfo[Constants.Key.Auth.fullName]!,
                                             username: userInfo[Constants.Key.Auth.username]!)
            
            return createUserProfile(newUser: newUser)
            
        } catch {
            return Observable.error(error)
        }
    }
    
    
    private func createUserProfile(newUser: CreatedUserProfile) -> Observable<Void> {
        return Observable.create { observer in
            
            Task {
                do {
                    try self.db
                        .collection(Constants.Firebase.FireStore.Collection.users)
                        .document(newUser.username)
                        .setData(from: newUser)
                    observer.onNext(())
                    observer.onCompleted()
                    
                } catch {
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    private func isUsernameAvailable(username: String) async -> Bool {
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
    
    func signIn(usernameEmail: String, password: String) {
        
//        if validatior.isEmailValid(textField: usernameEmail) {
//            // is email
//            Auth.auth().signIn(withEmail: usernameEmail, password: password) { [weak self] authResult, error in
//              guard let strongSelf = self else { return }
//              
//                //fetch data
//            }
//            
//        } else {
//            // is username
//        }

    }
}
