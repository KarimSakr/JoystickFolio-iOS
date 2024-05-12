//
//  String.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 06/05/2024.
//

import Foundation

extension String {
    func isEmail() -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    func isFullNameValid() -> Bool {
        let regex = "^[a-zA-Z0-9 ]{4,15}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    func isUsernameValid() -> Bool {
        let regex = #"^[a-zA-Z0-9]{4,20}$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    func isPasswordValid() -> Bool {
        return self.count >= 6
    }
    
    func isPasswordValid(repeatTextField: String) -> Bool {
        return self == repeatTextField && self.count >= 6
    }
}
