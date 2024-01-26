//
//  AuthenticationManager.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 25/01/2024.
//

import Foundation
import FirebaseAuth

final class AuthenticationManager {
    
    //MARK: - Managers
    private let databaseManager = DatabaseManager()
    
    //MARK: - Validators
    private let validatior = AuthValidator()
    
    func createUser(with userInfo: [String : String], completion: @escaping (Error?) -> Void) {
        
        guard let email = userInfo[Constants.Key.Auth.email], let password = userInfo[Constants.Key.Auth.password] else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            
            if let error = error {
                print(error.localizedDescription)
            } else {
                
                if let userId = authResult?.user.uid, let fullName = userInfo[Constants.Key.Auth.fullName], let userName = userInfo[Constants.Key.Auth.username] {
                    var newUser = CreatedUserProfile(email   : email,
                                                     fullName: fullName,
                                                     username: userName)

                    do {
                        try self?.databaseManager.createUserProfile(newUser: newUser, userId: userId) { error in
                            completion(error)
                        }
                    } catch {
                        completion(error)
                    }
                }
            }
        }
    }
    
    func signIn(usernameEmail: String, password: String) {
        
        if validatior.isEmailValid(textField: usernameEmail) {
            // is email
            Auth.auth().signIn(withEmail: usernameEmail, password: password) { [weak self] authResult, error in
              guard let strongSelf = self else { return }
              
                //fetch data
            }
            
        } else {
            // is username
        }

    }
}
