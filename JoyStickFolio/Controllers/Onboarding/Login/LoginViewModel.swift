//
//  LoginViewModel.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 04/02/2024.
//

import Foundation
import RxSwift
import FirebaseAuth

final class LoginViewModel {
    
    //MARK: - Managers
    private let authManager = AuthenticationManager()
    
    //MARK: - Validators
    private let validator = AuthValidator()
    
    func signIn(usernameEmail: String, password: String) async throws -> Observable<AuthDataResult> {
        
       return await authManager.signIn(usernameEmail: usernameEmail, password: password)
    }
}
