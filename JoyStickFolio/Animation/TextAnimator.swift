//
//  TextAnimator.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 05/12/2023.
//

import UIKit

class TextAnimator {
    
    static func animateTitle(text: String, timeInterval: TimeInterval, completion: @escaping (Character) -> Void) {
        var charIndex = 0.0
        let titleText = text
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: timeInterval * charIndex, repeats: false) { (timer) in
                
                let generator = UIImpactFeedbackGenerator(style: .light )
                generator.prepare()
                generator.impactOccurred()
                
                completion(letter)
            }
            charIndex += 1
        }
        
    }
}
