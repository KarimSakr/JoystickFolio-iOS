//
//  HamburgerMenuViewModel.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 04/02/2024.
//

import Foundation

final class HamburgerMenuViewModel {
    
    private let authManager = AuthenticationManager()
    
    func logout() {
        authManager.logout()
    }
}
