//
//  UIViewController + Extensions.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 18/05/2024.
//

import UIKit

extension UIViewController {
    
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
        
        view.addSubview(gradientOverlay)
        
        gradientOverlay.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        gradientOverlay.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        gradientOverlay.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        gradientOverlay.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
