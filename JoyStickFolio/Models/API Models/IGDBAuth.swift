//
//  IGDBAuth.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 07/02/2024.
//

import Foundation


struct IGDBAuth: Codable {
    
    var accessToken : String = ""
    var expiresIn   : Int    = 0
    var tokenType   : String = ""
    
    enum CodingKeys: String, CodingKey {
        
        case accessToken = "access_token"
        case expiresIn   = "expires_in"
        case tokenType   = "token_type"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        accessToken = try values.decodeIfPresent(String.self , forKey: .accessToken ) ?? ""
        expiresIn   = try values.decodeIfPresent(Int.self    , forKey: .expiresIn   ) ?? 0
        tokenType   = try values.decodeIfPresent(String.self , forKey: .tokenType   ) ?? ""
        
    }
    
    init() {
        
    }
    
}
