//
//  Constants.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 04/12/2023.
//

import Foundation

struct Constants {
    
    private init() {}
    
    
    //MARK: - Url
    struct Url {
        static let baseUrl = "https://api.igdb.com/v4"
        static let twitchAuth = "https://id.twitch.tv/oauth2/token"
        
    }
    
    //MARK: - Keys
    struct Key{
        
        struct Persistence {
            static let expiryDate  = "com.joystick.folio.expiryDate"
            static let accessToken = "com.joystick.folio.access.token"
        }
        
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
    
    struct BundleKey {
        static let fileName = "Config"
        static let fileExtension = "plist"
        static let clientId = "client_id"
        static let clientSecret = "client_secret"
    }
    
    //MARK: - Corner Radius
    static let cornerRadius = 8.0
}
