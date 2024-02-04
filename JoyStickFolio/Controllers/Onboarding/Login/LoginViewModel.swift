//
//  LoginViewModel.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 04/02/2024.
//

import Foundation

final class LoginViewModel {
    
    //MARK: - Managers
    private let authManager = AuthenticationManager()
    
    //MARK: - Validators
    private let validator = AuthValidator()
    
    func signIn(usernameEmail: String, password: String) async throws {
        
        // check validation to minimize calls
        guard validator.isPasswordValid(textfield: password) else {
            print("Wrong")
            throw AppError.wrongCredentials
        }
       try await authManager.signIn(usernameEmail: usernameEmail, password: password)
    }
}
