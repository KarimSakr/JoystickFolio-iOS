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
            var id               : Int?
            var ageRatings       : [Int]?
            var artworks         : [Int]?
            var category         : Int?
            var cover            : Int?
            var createdAt        : Int?
            var externalGames    : [Int]?
            var firstReleaseDate : Int?
            var gameModes        : String?
            var genres           : [Int]?
            var name             : String?
            var platforms        : [Int]?
            var releaseDates     : [Int]?
            var screenshots      : [Int]?
            var similarGames     : [Int]?
            var slug             : String?
            var summary          : String?
            var tags             : [Int]?
            var updatedAt        : Int?
            var url              : String?
            var versionParent    : Int?
            var versionTitle     : String?
            var checksum         : String?
            
            var imageUrl: String?
        }
        
        struct Cover {
            var id : Int?
            var url: String?
        }
    }
}
