//
//  AnaltyicsEvent.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 05/02/2024.
//

import Foundation
import FirebaseAnalytics

enum AnaltyicsEvent: String {
    
    case login, signup, signOut
    
    var event: String {
        switch self {
            
        case .login:
            return AnalyticsEventLogin
            
        case .signup:
            return AnalyticsEventSignUp
            
        case .signOut:
            return "Analytics_Event_Logout"
        }
    }
}
