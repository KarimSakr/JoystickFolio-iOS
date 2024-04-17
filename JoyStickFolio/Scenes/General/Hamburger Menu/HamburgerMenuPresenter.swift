//
//  HamburgerMenuPresenter.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 17/04/2024.

import UIKit

protocol HamburgerMenuPresentationLogic {
    func tappedLogOut()
}

class HamburgerMenuPresenter: HamburgerMenuPresentationLogic {
    weak var viewController: HamburgerMenuDisplayLogic?
    
    func tappedLogOut() {
        guard let viewController = viewController else { return }
        
        let actionSheet = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive) { _ in

            AnalyticsManager.logEvent(event: .signOut)
            viewController.logout()
            viewController.resetTabBarAndNavigationController()
            viewController.logout()
        })

        viewController.presentActionSheet(actionSheet: actionSheet)
    }
}
