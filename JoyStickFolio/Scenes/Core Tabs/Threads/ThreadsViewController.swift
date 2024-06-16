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
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        ThreadsConfigurator.shared.configure(viewController: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK:- View Lifecycle
extension ThreadsViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBottomGradient(color: .purpleApp, alpha: 0.3)
    }
    
}
