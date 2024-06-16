//
//  RegistrationModels.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 11/05/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import RxSwift
import Foundation

struct RegistrationModels {
    
    struct ViewModels {
        struct RegistrationProcess: Equatable {
            let title      : String
            let placeholder: String
            let buttonTitle: String
            let process    : Process
        }
    }
    
    struct Request {
        struct CreatedUserProfile: Encodable {
                   let email   : String
                   let fullName: String
                   let username: String
               }
    }
}
