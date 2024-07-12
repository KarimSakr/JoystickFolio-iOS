//
//  Array + Extensions.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 05/07/2024.
//

import Foundation

extension Array {
    func randomItem() -> Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}
