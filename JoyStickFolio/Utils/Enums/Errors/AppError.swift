//
//  AppError.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 29/01/2024.
//

import Foundation

enum AppError: LocalizedError {
    
    case usernameTaken,
         wrongCredentials,
         configFileMissing,
         missingClientId,
         missingClientSecret,
         sessionExpired
    
    
    var errorDescription: String? {
        switch self {
        case .usernameTaken:
            return "Username is already taken."
            
        case .wrongCredentials:
            return "Wrong credentials."
            
        case .configFileMissing:
            return "Configuration files are missing."
            
        case .missingClientId:
            return "The Client's ID is missing."
            
        case .missingClientSecret:
            return "The Client's key is missing."
            
        case .sessionExpired:
            return "Current session has expired."
        }
    }
}
