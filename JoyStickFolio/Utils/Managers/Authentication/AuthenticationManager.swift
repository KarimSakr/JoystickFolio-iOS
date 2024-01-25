//
//  AuthenticationManager.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 25/01/2024.
//

import Foundation
import FirebaseAuth

class AuthenticationManager {
    
    private let validatior = AuthValidator()
    
    func createUser(with userInfo: [String : String]) {
        
        guard let email = userInfo[Constants.Key.Auth.email], let password = userInfo[Constants.Key.Auth.password] else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                print(error.localizedDescription)
            } else {
                // save the rest
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
