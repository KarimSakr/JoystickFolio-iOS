//
//  GameDetailsModels.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 02/06/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import RxSwift
import Foundation
import UIKit

struct GameDetailsModels {
    
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
            
            var image: UIImage?
        }
        
        struct Platform {
            var id           : Int?   
            var abbreviation : String?
            var category     : Int?   
            var createdAt    : Int?   
            var name         : String?
            var platformLogo : Int?   
            var slug         : String?
            var updatedAt    : Int?   
            var url          : String?
            var versions     : [Int]? 
            var checksum     : String?
        }
        
        struct Screenshot {
            var id       : Int?
            var game     : Int?
            var height   : Int?
            var imageId  : String?
            var url      : String?
            var width    : Int?
            var checksum : String?
        }
    }
}
