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
    private let networkManager = NetworkManager()
    
    //MARK: - validator
    private let validator = AuthValidator()
    
    //MARK: - db
    private let db = Firestore.firestore()
    
    //MARK: - bag
    private let bag = DisposeBag()
    
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
        

        return Observable.create { observer in
            
            guard let bundle = Bundle.config else {
                observer.onError(AppError.configFileMissing)
                return Disposables.create()
            }
            
            let dict = NSDictionary(contentsOfFile: bundle) as! [String: Any]
            
            guard let clientId = dict[Constants.BundleKey.clientId] as? String else{
                observer.onError(AppError.missingClientId)
                return Disposables.create()
                
            }
            
            guard let clientSecret = dict[Constants.BundleKey.clientSecret] as? String else{
                observer.onError(AppError.missingClientSecret)
                return Disposables.create()
            }
            
            let parameters: Parameters = [
                "client_id" : clientId,
                "client_secret" : clientSecret,
                "grant_type" : "client_credentials",
            ]
            
            self.networkManager
                .request(router: .twitchAuth(parameters: parameters))
                .subscribe(onNext: { igdb in
                    do {
                        try self.databaseManager.saveIgdbInfo(igdb: igdb)
                        observer.onNext(igdb)
                        observer.onCompleted()
                    } catch {
                        observer.onError(error)
                    }
                    
                }, onError: { error in
                    observer.onError(error)
                })
                .disposed(by: self.bag)
            
            return Disposables.create()
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
