//
//  AuthValidator.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 05/12/2023.
//

import Foundation

class AuthValidator {
    
    func isFullNameValid(textField: String) -> Bool {
        let regex = "^[a-zA-Z0-9 ]{4,15}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: textField)
    }
    
    func isEmailValid(textField: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: textField)
    }
    
    func isUsernameValid(textField: String) -> Bool {
        let regex = #"^[a-zA-Z0-9]{4,20}$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: textField)
    }
    
    func isPasswordValid(textfield: String, repeatTextField: String) -> Bool {
        return textfield == repeatTextField && textfield.count >= 6
    }
    
    func isPasswordValid(textfield: String) -> Bool {
        return textfield.count >= 6
    }
}
