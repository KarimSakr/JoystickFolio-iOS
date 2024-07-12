//
//  PlatformAPI.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 05/07/2024.
//

import Foundation

struct PlatformAPI: Codable {
    
    var id           : Int?    = nil
    var abbreviation : String? = nil
    var category     : Int?    = nil
    var createdAt    : Int?    = nil
    var name         : String? = nil
    var platformLogo : Int?    = nil
    var slug         : String? = nil
    var updatedAt    : Int?    = nil
    var url          : String? = nil
    var versions     : [Int]?  = []
    var checksum     : String? = nil
    
    enum CodingKeys: String, CodingKey {
        
        case id           = "id"
        case abbreviation = "abbreviation"
        case category     = "category"
        case createdAt    = "created_at"
        case name         = "name"
        case platformLogo = "platform_logo"
        case slug         = "slug"
        case updatedAt    = "updated_at"
        case url          = "url"
        case versions     = "versions"
        case checksum     = "checksum"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id           = try values.decodeIfPresent(Int.self    , forKey: .id           )
        abbreviation = try values.decodeIfPresent(String.self , forKey: .abbreviation )
        category     = try values.decodeIfPresent(Int.self    , forKey: .category     )
        createdAt    = try values.decodeIfPresent(Int.self    , forKey: .createdAt    )
        name         = try values.decodeIfPresent(String.self , forKey: .name         )
        platformLogo = try values.decodeIfPresent(Int.self    , forKey: .platformLogo )
        slug         = try values.decodeIfPresent(String.self , forKey: .slug         )
        updatedAt    = try values.decodeIfPresent(Int.self    , forKey: .updatedAt    )
        url          = try values.decodeIfPresent(String.self , forKey: .url          )
        versions     = try values.decodeIfPresent([Int].self  , forKey: .versions     )
        checksum     = try values.decodeIfPresent(String.self , forKey: .checksum     )
        
    }
    
    init() {
        
    }
    
}
