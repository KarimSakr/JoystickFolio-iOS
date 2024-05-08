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
}
