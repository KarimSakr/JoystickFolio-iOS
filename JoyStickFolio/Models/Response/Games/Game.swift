//
//  Game.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 11/02/2024.
//

import Foundation

struct Game: Decodable {
    
    var id               : Int?    = nil
    var ageRatings       : [Int]?  = []
    var artworks         : [Int]?  = []
    var category         : Int?    = nil
    var cover            : Int?    = nil
    var createdAt        : Int?    = nil
    var externalGames    : [Int]?  = []
    var firstReleaseDate : Int?    = nil
    var gameModes        : String? = nil
    var genres           : [Int]?  = []
    var name             : String? = nil
    var platforms        : [Int]?  = []
    var releaseDates     : [Int]?  = []
    var screenshots      : [Int]?  = []
    var similarGames     : [Int]?  = []
    var slug             : String? = nil
    var summary          : String? = nil
    var tags             : [Int]?  = []
    var updatedAt        : Int?    = nil
    var url              : String? = nil
    var versionParent    : Int?    = nil
    var versionTitle     : String? = nil
    var checksum         : String? = nil
    
    enum CodingKeys: String, CodingKey {
        
        case id               = "id"
        case ageRatings       = "age_ratings"
        case artworks         = "artworks"
        case category         = "category"
        case cover            = "cover"
        case createdAt        = "created_at"
        case externalGames    = "external_games"
        case firstReleaseDate = "first_release_date"
        case gameModes        = "game_modes"
        case genres           = "genres"
        case name             = "name"
        case platforms        = "platforms"
        case releaseDates     = "release_dates"
        case screenshots      = "screenshots"
        case similarGames     = "similar_games"
        case slug             = "slug"
        case summary          = "summary"
        case tags             = "tags"
        case updatedAt        = "updated_at"
        case url              = "url"
        case versionParent    = "version_parent"
        case versionTitle     = "version_title"
        case checksum         = "checksum"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id               = try values.decodeIfPresent(Int.self    , forKey: .id               )
        ageRatings       = try values.decodeIfPresent([Int].self  , forKey: .ageRatings       )
        artworks         = try values.decodeIfPresent([Int].self  , forKey: .artworks         )
        category         = try values.decodeIfPresent(Int.self    , forKey: .category         )
        cover            = try values.decodeIfPresent(Int.self    , forKey: .cover            )
        createdAt        = try values.decodeIfPresent(Int.self    , forKey: .createdAt        )
        externalGames    = try values.decodeIfPresent([Int].self  , forKey: .externalGames    )
        firstReleaseDate = try values.decodeIfPresent(Int.self    , forKey: .firstReleaseDate )
        gameModes        = try values.decodeIfPresent(String.self , forKey: .gameModes        )
        genres           = try values.decodeIfPresent([Int].self  , forKey: .genres           )
        name             = try values.decodeIfPresent(String.self , forKey: .name             )
        platforms        = try values.decodeIfPresent([Int].self  , forKey: .platforms        )
        releaseDates     = try values.decodeIfPresent([Int].self  , forKey: .releaseDates     )
        screenshots      = try values.decodeIfPresent([Int].self  , forKey: .screenshots      )
        similarGames     = try values.decodeIfPresent([Int].self  , forKey: .similarGames     )
        slug             = try values.decodeIfPresent(String.self , forKey: .slug             )
        summary          = try values.decodeIfPresent(String.self , forKey: .summary          )
        tags             = try values.decodeIfPresent([Int].self  , forKey: .tags             )
        updatedAt        = try values.decodeIfPresent(Int.self    , forKey: .updatedAt        )
        url              = try values.decodeIfPresent(String.self , forKey: .url              )
        versionParent    = try values.decodeIfPresent(Int.self    , forKey: .versionParent    )
        versionTitle     = try values.decodeIfPresent(String.self , forKey: .versionTitle     )
        checksum         = try values.decodeIfPresent(String.self , forKey: .checksum         )
        
    }
    
    init() {
        
    }
    
}
