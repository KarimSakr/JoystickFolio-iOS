//
//  LoginViewModel.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 04/02/2024.
//

import Foundation
import RxSwift
import FirebaseAuth
import AppTrackingTransparency

final class LoginViewModel {
    
    //MARK: - Managers
    private let authManager = AuthenticationManager()
    
    //MARK: - Validators
    private let validator = AuthValidator()
    
    func signIn(usernameEmail: String, password: String) async throws -> Observable<AuthDataResult> {
        
       return await authManager.signIn(usernameEmail: usernameEmail, password: password)
    }
    
    func checkifUserIsSignedIn() -> Bool {
        
        if Auth.auth().currentUser == nil {
            return false
        }
        return true
    }
    //MARK: - requestIDFA
    func requestIDFA() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized, .denied, .notDetermined, .restricted: break
                @unknown default: break
                }
            }
        }
    }
}
