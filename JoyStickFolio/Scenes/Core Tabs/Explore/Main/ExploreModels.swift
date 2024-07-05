//
//  ExploreModels.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 12/05/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import RxSwift
import Foundation

struct ExploreModels {
    
    struct ViewModels {
        
        struct Game {
            var id                 : Int?
            var ageRatings         : [Int]?
            var alternativeNames   : [Int]?
            var category           : Int?
            var cover              : Int?
            var createdAt          : Int?
            var externalGames      : [Int]?
            var firstReleaseDate   : Int?
            var gameModes          : [Int]?
            var genres             : [Int]?
            var involvedCompanies  : [Int]?
            var keywords           : [Int]?
            var name               : String?
            var platforms          : [Int]?
            var playerPerspectives : [Int]?
            var releaseDates       : [Int]?
            var screenshots        : [Int]?
            var similarGames       : [Int]?
            var slug               : String?
            var storyline          : String?
            var summary            : String?
            var tags               : [Int]?
            var themes             : [Int]?
            var updatedAt          : Int?
            var url                : String?
            var videos             : [Int]?
            var websites           : [Int]?
            var checksum           : String?
            var gameLocalizations  : [Int]?
            
            var imageUrl: String?
        }
        
        struct Cover {
            var id : Int?
            var url: String?
        }
    }
}
