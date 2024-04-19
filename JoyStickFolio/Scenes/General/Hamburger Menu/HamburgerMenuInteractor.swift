//
//  HamburgerMenuInteractor.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 17/04/2024.

import UIKit

protocol HamburgerMenuBusinessLogic {
    
    var tableData: [[HamburgerMenuModels.Request.HamburgerMenuCell]] { get set }
    
    func logout()
    
}

protocol HamburgerMenuDataStore {
}

class HamburgerMenuInteractor: HamburgerMenuBusinessLogic, HamburgerMenuDataStore {
    var presenter: HamburgerMenuPresentationLogic?
    var repository: HamburgerMenuRepositoryBusinessLogic?
    
    var tableData = [[HamburgerMenuModels.Request.HamburgerMenuCell]]()
    
    private let authManager = AuthenticationManager()
    
    init() {
        configureModel()
    }
    
    func logout() {
        authManager.logout()
    }
    
    private func configureModel() {
        tableData.append([
            HamburgerMenuModels.Request.HamburgerMenuCell(title: "Edit Profile") { [weak self] in
                guard let self = self else { return }
                tappedEditProfile()
            },
            
            HamburgerMenuModels.Request.HamburgerMenuCell(title: "Invite Friends") { [weak self] in
                self?.tappedInviteFriends()
            },
        ])
        
        tableData.append([
            HamburgerMenuModels.Request.HamburgerMenuCell(title: "Terms of Service") { [weak self] in
                guard let self = self else { return }
                openUrl()
            },
            HamburgerMenuModels.Request.HamburgerMenuCell(title: "Privacy Policy"){ [weak self] in
                guard let self = self else { return }
                openUrl()
            },
            HamburgerMenuModels.Request.HamburgerMenuCell(title: "Help and Feedback") { [weak self] in
                guard let self = self else { return }
                openUrl()
            }])
        
        tableData.append([
            HamburgerMenuModels.Request.HamburgerMenuCell(title: "Support the developer") {
//                guard let self = self else { return }
                // do something
            }
        ])
        
        tableData.append([
            HamburgerMenuModels.Request.HamburgerMenuCell(title: "Log Out") { [weak self] in
                guard let self = self else { return }
                tappedLogOut()
            }
        ])
    }
}

extension HamburgerMenuInteractor {
    
    private func tappedEditProfile() {
        //TODO: implement feature
    }
    
    private func tappedInviteFriends() {
        //TODO: implement feature
    }
    
    private func openUrl() {
        //TODO: implement feature
    }
    
    private func tappedLogOut() {
        guard let presenter = presenter else { return }
        presenter.tappedLogOut()
    }
    
}
