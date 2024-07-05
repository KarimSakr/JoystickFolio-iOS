//
//  PlatformViewController.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 05/07/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import UIKit
import RxSwift

protocol PlatformViewControllerOutput {
    func getPlatform() -> Single<PlatformModels.ViewModels.Platform>
}

class PlatformViewController: BaseViewController {
    
    var interactor: PlatformViewControllerOutput?
    var router: PlatformRouter?
    var platform: PlatformModels.ViewModels.Platform?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        PlatformConfigurator.shared.configure(viewController: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

//MARK: - View Lifecycle -
extension PlatformViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([

        ])
    }
    
}

//MARK: - Get Data -
extension PlatformViewController {
    fileprivate
    func getPlatform() {
        interactor!
            .getPlatform()
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] platform in
                guard let self = self else { return }
                self.platform = platform
                self.updateUI()
            } onFailure: { error in
                self.showSnackBar(with: error.localizedDescription)
            }
            .disposed(by: bag)
    }
}

//MARK: - UI -
extension PlatformViewController {
    fileprivate
    func updateUI() {
        
    }
}
