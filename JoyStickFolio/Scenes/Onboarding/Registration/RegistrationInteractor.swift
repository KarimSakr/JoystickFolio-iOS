//
//  RegistrationInteractor.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 11/05/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import Foundation
import RxSwift
import FirebaseAuth
import FirebaseFirestore

protocol RegistrationInteractorOutput {
    
    
}

protocol RegistrationDataStore {
    
}

class RegistrationInteractor: RegistrationDataStore {
    
    var presenter: RegistrationInteractorOutput?
    var data: [String : String] = [:]
    private let db = Firestore.firestore()
    
}

extension RegistrationInteractor: RegistrationViewControllerOutput {
    
    func registerUser() async -> Single<Void> {
           let newUser = RegistrationModels.Request.CreatedUserProfile(email   : data[Constants.Key.Auth.email]!,
                                                                       fullName: data[Constants.Key.Auth.fullName]!,
                                                                       username: data[Constants.Key.Auth.username]!)
           let password = data[Constants.Key.Auth.password]!
           
           return await createAccount(newUser: newUser, password: password)
       }
    
    func addData(to key: String, value: String) {
        data[key] = value
    }
    
    func resetData() {
        data = [:]
    }
    
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
       


//       
//       private func resetRegistration() {
//           guard let presenter = presenter else { return }
//           
//           data = [:]
//           progressValue = 0
//           index = 0
//           
//           presenter.resetRegistration(mainTextFieldPlaceholder: processes[index].placeholder, buttonSetTitle: processes[index].buttonTitle, titleLableText: processes[index].title)
//       }
//       
//       private func isUsernameAvailable(username: String) async -> Bool {
//           return await authenticationManager.isUsernameAvailable(username: username)
//       }
//       

}

//MARK: - Helper Functions -
extension RegistrationInteractor {
    func createAccount(newUser: RegistrationModels.Request.CreatedUserProfile, password: String) async -> Single<Void> {
        
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
                        single(.success(()))
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
}
