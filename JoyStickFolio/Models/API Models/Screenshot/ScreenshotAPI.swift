//
//  ScreenshotAPI.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 05/07/2024.
//

import Foundation
import Foundation

struct ScreenshotAPI: Codable {
    
    var id       : Int?    = nil
    var game     : Int?    = nil
    var height   : Int?    = nil
    var imageId  : String? = nil
    var url      : String? = nil
    var width    : Int?    = nil
    var checksum : String? = nil
    
    enum CodingKeys: String, CodingKey {
        
        case id       = "id"
        case game     = "game"
        case height   = "height"
        case imageId  = "image_id"
        case url      = "url"
        case width    = "width"
        case checksum = "checksum"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id       = try values.decodeIfPresent(Int.self    , forKey: .id       )
        game     = try values.decodeIfPresent(Int.self    , forKey: .game     )
        height   = try values.decodeIfPresent(Int.self    , forKey: .height   )
        imageId  = try values.decodeIfPresent(String.self , forKey: .imageId  )
        url      = try values.decodeIfPresent(String.self , forKey: .url      )
        width    = try values.decodeIfPresent(Int.self    , forKey: .width    )
        checksum = try values.decodeIfPresent(String.self , forKey: .checksum )
        
    }
    
    init() {
        
    }
    
}
