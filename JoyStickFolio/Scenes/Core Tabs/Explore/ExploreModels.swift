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
            var name : String?
            var cover: Int?
            var imageUrl: String?
        }
        
        struct Cover {
            var id : Int?
            var url: String?
        }
    }
}
