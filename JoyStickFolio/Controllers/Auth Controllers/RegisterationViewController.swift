//
//  RegisterationViewController.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 03/12/2023.
//

import UIKit

class RegisterationViewController: UIViewController {
    
    private let progressBarView: UIProgressView = {
        let progressBar = UIProgressView()
        progressBar.progress = 0.25
        progressBar.progressTintColor = .accent
        return progressBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(progressBarView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        progressBarView.frame = CGRect(x: (view.width / 2) - ((view.width * 0.8) / 2),
                                       y: view.bottom - 40,
                                       width: view.width * 0.8,
                                       height: 10)
    }
}
