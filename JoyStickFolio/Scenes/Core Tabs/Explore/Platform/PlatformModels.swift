//
//  PlatformModels.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 05/07/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import RxSwift
import Foundation

struct PlatformModels {
    
    struct ViewModels {
        
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
    }
}
