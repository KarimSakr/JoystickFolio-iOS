//
//  UIView.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 03/12/2023.
//

import Foundation
import UIKit

//MARK: - Size and Origin -
extension UIView {
    
    var width: CGFloat {
        return frame.size.width
    }
    
    var height: CGFloat {
        return frame.size.height
    }
    
    var top: CGFloat {
        return frame.origin.y
    }
    
    var bottom: CGFloat {
        return frame.origin.y + frame.size.height
    }
    
    var left: CGFloat {
        return frame.origin.x
    }
    
    var right: CGFloat {
        return frame.origin.x + frame.size.width
    }
}

extension UIView {

    func addBottomGradient(color: UIColor, alpha: CGFloat) {
        lazy var gradientOverlay: GradientView = {
            let view = GradientView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.startColor = color.withAlphaComponent(alpha)
            view.endColor = .clear
            view.direction = .bottomToTop
            view.startLocation = 0
            view.endLocation = 0.5
            return view
        }()
        
        self.addSubview(gradientOverlay)
        self.sendSubviewToBack(gradientOverlay)
        
        gradientOverlay.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        gradientOverlay.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        gradientOverlay.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        gradientOverlay.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}
