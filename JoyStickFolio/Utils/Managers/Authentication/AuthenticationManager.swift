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
            return try await databaseManager.fetchEmail(of: usernameEmail)
        } else {
            // email used
            return usernameEmail
        }
    }
    
}
