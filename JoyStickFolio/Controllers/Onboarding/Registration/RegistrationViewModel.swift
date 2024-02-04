//
//  RegistrationViewModel.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 03/02/2024.
//

import Foundation
import RxSwift

final class RegistrationViewModel {
    
    //MARK: - Managers
    private let authenticationManager = AuthenticationManager()
    private let databaseManager = DatabaseManager()
    
    //MARK: - Auth Validator
    private let validator = AuthValidator()
    
    //MARK: - User Data
    var data: [String : String] = [:]
    
    func isUsernameAvailble(username: String) async -> Bool {
        return await databaseManager.isUsernameAvailable(username: username)
    }
    
    //MARK: - registerUser
    func registerUser() async -> Observable<Void> {
        return await authenticationManager.createUser(with: data)
    }
    
    //MARK: - fullNameEntered
    func fullNameEntered(fullName: String) {
        data[Constants.Key.Auth.fullName] = fullName
    }
    
    //MARK: - emailEntered
    func emailEntered(email: String) {
        data[Constants.Key.Auth.email] = email
    }
    
    //MARK: - usernameEntered
    func usernameEntered(username: String) {
        data[Constants.Key.Auth.username] = username
    }
    
    //MARK: - passwordEnetred
    func passwordEntered(password: String) {
        data[Constants.Key.Auth.password] = password
    }
    
    //MARK: - Validators
    func isFullNameValid(textField: String) -> Bool {
        return validator.isFullNameValid(textField: textField)
    }
    
    func isEmailValid(textField: String) -> Bool {
        return validator.isEmailValid(textField: textField)
    }
    
    func isUsernameValid(textField: String) -> Bool {
        return validator.isUsernameValid(textField: textField)
    }
    
    func isPasswordValid(textfield: String, repeatTextField: String) -> Bool {
        return validator.isPasswordValid(textfield: textfield, repeatTextField: repeatTextField)
    }
}
