//
//  LoginRouter.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 06/05/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import UIKit

protocol LoginRouterDataPassing: AnyObject {
    var dataStore: LoginDataStore? { get }
}

class LoginRouter: LoginRouterDataPassing{
    
    weak var viewController: LoginViewController!
    var dataStore: LoginDataStore?
    
    init(viewController: LoginViewController,
         dataStore: LoginDataStore){
        self.viewController = viewController
        self.dataStore = dataStore
    }
    
}

extension LoginRouter {
    
    func dismissLoginScreen() {
        viewController.dismiss(animated: true)
    }
    
    func goToCreateAccount(completion: (() -> Void)? = nil) {
        let vc = RegistrationViewController()
        vc.title = "Create Account"
        vc.dismissalCompletion = {
            completion?()
        }
        viewController.present(UINavigationController(rootViewController: vc), animated: true)
    }
}
