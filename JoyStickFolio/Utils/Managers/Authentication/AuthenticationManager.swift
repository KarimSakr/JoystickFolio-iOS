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
    
    private let validator = AuthValidator()
    
    private let db = Firestore.firestore()
    
    func createUser(with userInfo: [String : String]) async -> Observable<Void> {
        
        do {
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
    
    //MARK: - signIn
    func signIn(usernameEmail: String, password: String) async -> Observable<AuthDataResult> {
        
        return Observable.create { observer in
            Task {
                do {
                    let email = try await self.userEmail(usernameEmail: usernameEmail)
                    
                    let user = try await Auth
                        .auth()
                        .signIn(withEmail: email, password: password)
                    
                    observer.onNext(user)
                    observer.onCompleted()
                    
                    
                } catch {
                    observer.onError(error)
                }
                
            }
            return Disposables.create()
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
        }
        catch {
            print("already logged out")
        }
    }
    
    //MARK: - userEmail
    private func userEmail(usernameEmail: String) async throws -> String {
        if !validator.isEmailValid(textField: usernameEmail) {
            // username used
            return try await databaseManager.fetchEmail(of: usernameEmail)
        } else {
            // email used
            return usernameEmail
        }
    }
    
}
