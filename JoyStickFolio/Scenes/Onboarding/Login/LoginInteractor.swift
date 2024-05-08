//
//  LoginInteractor.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 06/05/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import Foundation
import RxSwift
import FirebaseAuth
import FirebaseFirestore

protocol LoginInteractorOutput {
    
    
}

protocol LoginDataStore {
    
}

class LoginInteractor: LoginDataStore{
    
    var presenter: LoginInteractorOutput?
    
    private let db = Firestore.firestore()
    
}

extension LoginInteractor: LoginViewControllerOutput{
    
    func login(usernameEmail: String, password: String) async -> Single<FirebaseAuth.AuthDataResult> {
        return Single<FirebaseAuth.AuthDataResult>
            .create { single in
                Task {
                    do {
                        let email = try await self.userEmail(usernameEmail: usernameEmail)
                        let signInResult = try await Auth.auth().signIn(withEmail: email, password: password)
                        single(.success(signInResult))
                    } catch {
                        single(.failure(error))
                    }
                }
                return Disposables.create()
            }
    }
    
    func checkIfUserIsSignedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
}

//MARK: - Helper Functions -
extension LoginInteractor {
    fileprivate
    func userEmail(usernameEmail: String) async throws -> String {
        if usernameEmail.isEmail() == true {
            // username used
            return try await fetchEmail(of: usernameEmail)
        } else {
            // email used
            return usernameEmail
        }
    }
    
    fileprivate
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
}
