import Foundation

struct GameAPI: Codable {
    
    var id                 : Int?    = nil
    var ageRatings         : [Int]?  = []
    var alternativeNames   : [Int]?  = []
    var category           : Int?    = nil
    var cover              : Int?    = nil
    var createdAt          : Int?    = nil
    var externalGames      : [Int]?  = []
    var firstReleaseDate   : Int?    = nil
    var gameModes          : [Int]?  = []
    var genres             : [Int]?  = []
    var involvedCompanies  : [Int]?  = []
    var keywords           : [Int]?  = []
    var name               : String? = nil
    var platforms          : [Int]?  = []
    var playerPerspectives : [Int]?  = []
    var releaseDates       : [Int]?  = []
    var screenshots        : [Int]?  = []
    var similarGames       : [Int]?  = []
    var slug               : String? = nil
    var storyline          : String? = nil
    var summary            : String? = nil
    var tags               : [Int]?  = []
    var themes             : [Int]?  = []
    var updatedAt          : Int?    = nil
    var url                : String? = nil
    var videos             : [Int]?  = []
    var websites           : [Int]?  = []
    var checksum           : String? = nil
    var gameLocalizations  : [Int]?  = []
    
    enum CodingKeys: String, CodingKey {
        
        case id                 = "id"
        case ageRatings         = "age_ratings"
        case alternativeNames   = "alternative_names"
        case category           = "category"
        case cover              = "cover"
        case createdAt          = "created_at"
        case externalGames      = "external_games"
        case firstReleaseDate   = "first_release_date"
        case gameModes          = "game_modes"
        case genres             = "genres"
        case involvedCompanies  = "involved_companies"
        case keywords           = "keywords"
        case name               = "name"
        case platforms          = "platforms"
        case playerPerspectives = "player_perspectives"
        case releaseDates       = "release_dates"
        case screenshots        = "screenshots"
        case similarGames       = "similar_games"
        case slug               = "slug"
        case storyline          = "storyline"
        case summary            = "summary"
        case tags               = "tags"
        case themes             = "themes"
        case updatedAt          = "updated_at"
        case url                = "url"
        case videos             = "videos"
        case websites           = "websites"
        case checksum           = "checksum"
        case gameLocalizations  = "game_localizations"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id                 = try values.decodeIfPresent(Int.self    , forKey: .id                 )
        ageRatings         = try values.decodeIfPresent([Int].self  , forKey: .ageRatings         )
        alternativeNames   = try values.decodeIfPresent([Int].self  , forKey: .alternativeNames   )
        category           = try values.decodeIfPresent(Int.self    , forKey: .category           )
        cover              = try values.decodeIfPresent(Int.self    , forKey: .cover              )
        createdAt          = try values.decodeIfPresent(Int.self    , forKey: .createdAt          )
        externalGames      = try values.decodeIfPresent([Int].self  , forKey: .externalGames      )
        firstReleaseDate   = try values.decodeIfPresent(Int.self    , forKey: .firstReleaseDate   )
        gameModes          = try values.decodeIfPresent([Int].self  , forKey: .gameModes          )
        genres             = try values.decodeIfPresent([Int].self  , forKey: .genres             )
        involvedCompanies  = try values.decodeIfPresent([Int].self  , forKey: .involvedCompanies  )
        keywords           = try values.decodeIfPresent([Int].self  , forKey: .keywords           )
        name               = try values.decodeIfPresent(String.self , forKey: .name               )
        platforms          = try values.decodeIfPresent([Int].self  , forKey: .platforms          )
        playerPerspectives = try values.decodeIfPresent([Int].self  , forKey: .playerPerspectives )
        releaseDates       = try values.decodeIfPresent([Int].self  , forKey: .releaseDates       )
        screenshots        = try values.decodeIfPresent([Int].self  , forKey: .screenshots        )
        similarGames       = try values.decodeIfPresent([Int].self  , forKey: .similarGames       )
        slug               = try values.decodeIfPresent(String.self , forKey: .slug               )
        storyline          = try values.decodeIfPresent(String.self , forKey: .storyline          )
        summary            = try values.decodeIfPresent(String.self , forKey: .summary            )
        tags               = try values.decodeIfPresent([Int].self  , forKey: .tags               )
        themes             = try values.decodeIfPresent([Int].self  , forKey: .themes             )
        updatedAt          = try values.decodeIfPresent(Int.self    , forKey: .updatedAt          )
        url                = try values.decodeIfPresent(String.self , forKey: .url                )
        videos             = try values.decodeIfPresent([Int].self  , forKey: .videos             )
        websites           = try values.decodeIfPresent([Int].self  , forKey: .websites           )
        checksum           = try values.decodeIfPresent(String.self , forKey: .checksum           )
        gameLocalizations  = try values.decodeIfPresent([Int].self  , forKey: .gameLocalizations  )
        
    }
    
    init() {
        
    }
    
}
