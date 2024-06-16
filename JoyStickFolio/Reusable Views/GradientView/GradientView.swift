//
//  GradientView.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 18/05/2024.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    
    enum GradientDirection {
        case leftToRight,
             rightToLeft,
             topToBottom,
             bottomToTop,
             topLeftToBottomRight,
             bottomRightToTopLeft,
             topRightToBottomLeft,
             bottomLeftToTopRight
    }
    
    @IBInspectable
    var startColor: UIColor = UIColor.white { didSet { updateColors() }}
    @IBInspectable
    var endColor: UIColor = UIColor.white { didSet { updateColors() }}
    
    @IBInspectable
    var startLocation: Double = 0 { didSet { updateLocations() }}
    @IBInspectable
    var endLocation: Double = 0 { didSet { updateLocations() }}

    var direction: GradientDirection = .bottomToTop { didSet { updateLocations() }}
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
    func updatePoints() {
        
        switch direction {
            
        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
            
        case .rightToLeft:
            gradientLayer.startPoint = CGPoint(x: 1, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0, y: 0.5)
            
        case .topToBottom:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
            
        case .bottomToTop:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
            
        case .topLeftToBottomRight:
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
            
        case .bottomRightToTopLeft:
            gradientLayer.startPoint = CGPoint(x: 1, y: 1)
            gradientLayer.endPoint = CGPoint(x: 0, y: 0)
            
        case .topRightToBottomLeft:
            gradientLayer.startPoint = CGPoint(x: 1, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
            
        case .bottomLeftToTopRight:
            gradientLayer.startPoint = CGPoint(x: 0, y: 1)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        }
    }
    
    fileprivate
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    
    fileprivate
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
}
