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
import Alamofire

final class AuthenticationManager {
    
    //MARK: - Managers
    private let databaseManager = DatabaseManager()
    
    //MARK: - validator
    private let validator = AuthValidator()
    
    //MARK: - db
    private let db = Firestore.firestore()
    
    //MARK: - bag
    private let bag = DisposeBag()
    
    func registerUser(newUser: RegistrationModels.Request.CreatedUserProfile, password: String) async -> Single<Void> {
        
        do {
            try await Auth.auth()
                .createUser(withEmail: newUser.email, password: password)
            
            return Single.create { single in
                
                Task {
                    do {
                        try self.db
                            .collection(Constants.Firebase.FireStore.Collection.users)
                            .document(newUser.username)
                            .setData(from: newUser)
                        single(.success({}()))
                    } catch {
                        single(.failure(error))
                    }
                }
                
                return Disposables.create()
            }
            
        } catch {
            return Single.error(error)
        }
    }
    
    
    //MARK: - signIn
    func signIn(usernameEmail: String, password: String) async -> Single<AuthDataResult> {
        
        return Single.create { single in
            Task {
                do {
                    let email = try await self.userEmail(usernameEmail: usernameEmail)
                    
                    let user = try await Auth
                        .auth()
                        .signIn(withEmail: email, password: password)
                    
                    single(.success(user))
                
                } catch {
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    //MARK: - logout
    func logout() {
        do {
            try Auth.auth().signOut()
        }
        catch {
            print("already logged out")
        }
    }
    
    //MARK: - twitchAuthentication
    func twitchAuthentication() -> Observable<IGDBAuth> {
        
        return APIClient.shared
            .request(router: .twitchAuth)
    }
    
    //MARK: - userEmail
    private func userEmail(usernameEmail: String) async throws -> String {
        if !validator.isEmailValid(textField: usernameEmail) {
            // username used
            return try await fetchEmail(of: usernameEmail)
        } else {
            // email used
            return usernameEmail
        }
    }
    
    //MARK: - fetchEmail
    private func fetchEmail(of username: String) async throws -> String {
        
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
    
}
