//
//  Constants.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 04/12/2023.
//

import Foundation

struct Constants {
    
    struct Url {
        
        static func twitchAuth(clientId: String, clientSecret: String) -> String {
            return "https://id.twitch.tv/oauth2/token?client_id=\(clientId)&client_secret=\(clientSecret)&grant_type=client_credentials"
        }
    }
    
    //MARK: - Keys
    struct Key{
        
        // keys for authentication
        //MARK: - Auth
        struct Auth {
            static let email    = "email"
            static let fullName = "fullName"
            static let username = "username"
            static let password = "password"
        }
        
        
        struct UserInfo {
            static let id = "id"
        }
    }
    
    struct Firebase {
        
        struct FireStore {
            
            struct Collection {
                static let users = "users"
            }
        }
    }
    
    //MARK: - Corner Radius
    static let cornerRadius = 8.0
}
