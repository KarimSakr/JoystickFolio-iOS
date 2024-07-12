//
//  PlatformViewController.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 05/07/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import UIKit
import RxSwift
import WebKit

protocol PlatformViewControllerOutput {
    func getPlatform() -> Single<PlatformModels.ViewModels.Platform>
}

class PlatformViewController: BaseViewController {
    
    var interactor: PlatformViewControllerOutput?
    var router: PlatformRouter?
    var platform: PlatformModels.ViewModels.Platform?
    
    lazy var rectangleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .purpleApp
        return view
    }()
    
    lazy var webView : WKWebView = {
        let view = WKWebView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        PlatformConfigurator.shared.configure(viewController: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

//MARK: - View Lifecycle -
extension PlatformViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addViews()
        self.getPlatform()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([
            
            rectangleView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rectangleView.topAnchor.constraint(equalTo: view.topAnchor),
            rectangleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rectangleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
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
    func addViews(){
        view.addSubview(rectangleView)
        view.addSubview(webView)
    }
    
    fileprivate
    func updateUI() {
        let url = URL(string: platform?.url ?? "https://www.google.com")!
        webView.load(URLRequest(url: url))
    }
}
