//
//  JSONSerializable.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 19/05/2024.
//

import Foundation

protocol JSONSerializable: Codable {}

extension JSONSerializable {
     
    func toJSON() throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(self)
    }
}
