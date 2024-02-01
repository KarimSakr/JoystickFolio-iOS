//
//  AppError.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 29/01/2024.
//

import Foundation

enum AppError: LocalizedError {
    case usernameTaken
    
    
    var errorDescription: String? {
        switch self {
        case .usernameTaken:
            return "Username is already taken."
        }
    }
}
