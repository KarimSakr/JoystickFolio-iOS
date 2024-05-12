//
//  ThreadsViewController.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 12/05/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import UIKit
import RxSwift

protocol ThreadsViewControllerOutput {
    
}

class ThreadsViewController: UIViewController {
    
    var interactor: ThreadsViewControllerOutput?
    var router: ThreadsRouter?
    
    
    
}

//MARK:- View Lifecycle
extension ThreadsViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ThreadsConfigurator.shared.configure(viewController: self)
    }
    
}
