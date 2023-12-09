//
//  AuthValidator.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 05/12/2023.
//

import Foundation

class AuthValidator {
    
    func isFullNameValid(textField: String) -> Bool {
        // valid if not empty and character count between 4 and 15
        return (textField.range(of: #"^[a-zA-Z0-9!@#$%^&*()_+{}\[\]:;<>,.?/~\\-]{4,15}$"#, options: .regularExpression) != nil)
    }
    
    func isEmailValid(textField: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: textField)
        
    }
    
    func isUsernameValid(textField: String) -> Bool {
        // valid if not empty, character count between 4 and 20, and no special charcters
        return (textField.range(of: #"^[a-zA-Z0-9!@#$%^&*()_+{}\[\]:;<>,.?/~\\-]{4,20}$"#, options: .regularExpression) != nil)
    }
    
    func isPasswordValid(textfield: String, repearTextField: String) -> Bool {
        return textfield == repearTextField && textfield.count >= 6
    }
}
