//
//  LoginViewController.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 11/03/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import RxSwift
protocol LoginDisplayLogic: AnyObject {
    
    func showLoading()
    func hideLoading()
    func animateText()
    func addMainSubviews()
    func showSnackbar(with message: String)
    
}

class LoginViewController: UIViewController, LoginDisplayLogic {
    
    var interactor: LoginBusinessLogic?
    var router: LoginRouter?
    
    private let bag = DisposeBag()
    
    private let viewModel = LoginViewModel()
    
    private let animator = TextAnimator()
    
    
    private lazy var usernameEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username or Email..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder  = "Password..."
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .accent
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create an account?", for: .normal)
        button.layer.masksToBounds = true
        button.setTitleColor(.label , for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.purpleApp.cgColor, UIColor.pinkApp.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        return gradient
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 50.0)
        return label
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
}

//MARK: - LifeCycle
extension LoginViewController {
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        loginButton.addTarget(self,
                              action: #selector(didTapLoginButton),
                              for: .touchUpInside)
        
        createAccountButton.addTarget(self,
                                      action: #selector(didTapCreateAccountButton),
                                      for: .touchUpInside)
        
        gradientLayer.frame = headerView.bounds
        headerView.layer.addSublayer(gradientLayer)
        headerView.addSubview(titleLabel)
        
        animateText()
        
        addMainSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLayoutConstraint.activate([
            
            // Header View constraints
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3),
            
            // Username/Email Field constraints
            usernameEmailField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 40),
            usernameEmailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            usernameEmailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            usernameEmailField.heightAnchor.constraint(equalToConstant: 52),
            
            
            // Password Field constraints
            passwordField.topAnchor.constraint(equalTo: usernameEmailField.bottomAnchor, constant: 15),
            passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            passwordField.heightAnchor.constraint(equalToConstant: 52),
            
            
            // Login Button constraints
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 10),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            loginButton.heightAnchor.constraint(equalToConstant: 52),
            
            
            // Create Account Button constraints
            createAccountButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            createAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            createAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            createAccountButton.heightAnchor.constraint(equalToConstant: 52),
            
            
            // Activity Indicator constraints
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
        ])
        
    }
    
}

//MARK: - setup
extension LoginViewController {
    
    private func setup() {
        let viewController = self
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
}

//MARK: - functions
extension LoginViewController {
    
    #warning("Refactor login and create account functions")
    @objc private func didTapLoginButton() {
//        showLoading()
//        Task {
//            do {
//                try await viewModel.signIn(usernameEmail: usernameEmailField.text ?? "", password: passwordField.text ?? "")
//                    .subscribe(onError: { [weak self] error in
//                        self?.hideLoading()
//                        self?.showSnackbar(with: error.localizedDescription)
//                        
//                    }, onCompleted: {
//                        
//                        self.viewModel.requestIDFA()
//                        
//                        AnalyticsManager.logEvent(event: .login)
//                        
//                        DispatchQueue.main.async{
//                            
//                            self.dismiss(animated: true, completion: nil)
//                        }
//                    })
//                    .disposed(by: bag)
//                
//            } catch {
//                hideLoading()
//                showSnackbar(with: error.localizedDescription)
//            }
//            
//        }
    }
    //MARK: - didTapCreateAccountButton
    @objc private func didTapCreateAccountButton() {
        createAccountButtonTapped() {
            if self.viewModel.checkifUserIsSignedIn() {
                self.dismiss(animated: true)
            }
        }
    }
    
    func createAccountButtonTapped(completion: (() -> Void)? = nil) {
        let vc = RegistrationViewController()
        vc.title = "Create Account"
        vc.dismissalCompletion = {
             completion?()
         }
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    
    func addMainSubviews() {
        DispatchQueue.main.async {
            self.view.addSubview(self.headerView)
            self.view.addSubview(self.usernameEmailField)
            self.view.addSubview(self.passwordField)
            self.view.addSubview(self.loginButton)
            self.view.addSubview(self.createAccountButton)
            self.view.addSubview(self.activityIndicator)
        }
    }
    
    func showLoading() {
        usernameEmailField.isHidden  = true
        passwordField.isHidden       = true
        loginButton.isHidden         = true
        createAccountButton.isHidden = true
        activityIndicator.isHidden   = false
        
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.usernameEmailField.isHidden  = false
            self.passwordField.isHidden       = false
            self.loginButton.isHidden         = false
            self.createAccountButton.isHidden = false
            self.activityIndicator.isHidden   = true
            self.activityIndicator.stopAnimating()
        }
    }
    
    func animateText() {
        titleLabel.text = ""
        animator.animateTitle(text: "JoystickFolio", timeInterval: 0.1) { letter in
            self.titleLabel.text?.append(letter)
            self.titleLabel.frame = CGRect(x: .zero,
                                           y: self.view.top,
                                           width: self.headerView.width,
                                           height: self.headerView.height)
        }
    }
    
    func showSnackbar(with message: String) {
        DispatchQueue.main.async {
            AppSnackBar.make(in: self.view!, message: message, duration: .lengthLong).show()
        }
    }
}


//MARK: - textField
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == usernameEmailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField{
            didTapLoginButton()
        }
        return true
    }
}
