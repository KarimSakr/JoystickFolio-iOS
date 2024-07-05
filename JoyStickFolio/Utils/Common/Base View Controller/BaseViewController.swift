//
//  BaseViewController.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 01/07/2024.
//

import UIKit
import RxSwift
import SnackBar

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addBottomGradient(color: .purpleApp, alpha: 0.3)
    }
    
    var bag = DisposeBag()
}

//MARK: - Snackbar -
extension BaseViewController {
    
    func showSnackBar(with message: String, duration: SnackBar.Duration = .lengthShort) {
        AppSnackBar.make(in: self.view!, message: message, duration: duration).show()
    }
    
    func showSnackBar(with message: String, duration: SnackBar.Duration = .infinite, and actionTitle: String, action: @escaping () -> Void) {
        AppSnackBar.make(in: self.view!, message: message, duration: duration).setAction(with: actionTitle) {
            action()
        }.show()
    }
}

//MARK: - Background -
extension BaseViewController {
    
    private func addBottomGradient(color: UIColor, alpha: CGFloat) {
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
        view.sendSubviewToBack(gradientOverlay)
        
        gradientOverlay.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        gradientOverlay.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        gradientOverlay.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        gradientOverlay.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

}
