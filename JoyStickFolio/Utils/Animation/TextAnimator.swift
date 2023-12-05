//
//  TextAnimator.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 05/12/2023.
//

import Foundation

class TextAnimator {
    
    func animateTitle(text: String, completion: @escaping (Character) -> Void) {
        var charIndex = 0.0
        let titleText = text
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.05 * charIndex, repeats: false) { (timer) in
                completion(letter)

            }
            charIndex += 1
        }
        
    }
}
