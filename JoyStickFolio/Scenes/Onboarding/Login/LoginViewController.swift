//
//  LoginViewController.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 06/05/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import UIKit
import RxSwift
import FirebaseAuth

protocol LoginViewControllerOutput {
    
    func login(usernameEmail: String, password: String) async -> Single<FirebaseAuth.AuthDataResult>
    
    func checkIfUserIsSignedIn() -> Bool
}

class LoginViewController: UIViewController {
    
    var interactor: LoginViewControllerOutput?
    var router: LoginRouter?
    
    private var disposeBag = DisposeBag()
    
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
        label.text = ""
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 50.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    
}

//MARK:- View Lifecycle
extension LoginViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        LoginConfigurator.shared.configure(viewController: self)
        addMainSubviews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateText()
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
            
            // title label constraints
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3),
        ])
        
        setupHeader()
        
    }
    
}
//MARK: - setup -
extension LoginViewController {
    
    func setupHeader() {
        gradientLayer.frame = headerView.bounds
        headerView.layer.addSublayer(gradientLayer)
        headerView.addSubview(titleLabel)
    }
    
    func setupButtons() {
        loginButton.addTarget(self,
                              action: #selector(didTapLoginButton),
                              for: .touchUpInside)
        
        createAccountButton.addTarget(self,
                                      action: #selector(didTapCreateAccountButton),
                                      for: .touchUpInside)
    }
    
}

//MARK: - functions -
extension LoginViewController {
    
    @objc private func didTapLoginButton() {
        
        guard let interactor = interactor else { return }
        Task {
            startLoading()
            await interactor.login(usernameEmail: usernameEmailField.text ?? "" ,password: passwordField.text ?? "")
                .observe(on: MainScheduler.instance)
                .subscribe { [weak self] authResult in
                    guard let self = self else { return }
                    self.stopLoading()
                    self.dismiss(animated: true, completion: nil)
                } onFailure: { [weak self] error in
                    guard let self = self else { return }
                    self.showSnackbar(with: error.localizedDescription)
                    self.stopLoading()
                }
                .disposed(by: disposeBag)
        }

    }
    
    @objc private func didTapCreateAccountButton() {
        guard let router = router else { return }
        router.goToCreateAccount() {
            guard let interactor = self.interactor else { return }
            if interactor.checkIfUserIsSignedIn() {
                router.dismissLoginScreen()
            }
        }
    }
    
    func addMainSubviews() {
        
        view.addSubview(headerView)
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(createAccountButton)
        view.addSubview(activityIndicator)
        view.addSubview(titleLabel)
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
    }
    
    func startLoading() {
        usernameEmailField.isHidden  = true
        passwordField.isHidden       = true
        loginButton.isHidden         = true
        createAccountButton.isHidden = true
        activityIndicator.isHidden   = false
        
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        
        usernameEmailField.isHidden  = false
        passwordField.isHidden       = false
        loginButton.isHidden         = false
        createAccountButton.isHidden = false
        activityIndicator.isHidden   = true
        activityIndicator.stopAnimating()
    }
    
    func animateText() {
        titleLabel.text = ""
        TextAnimator.animateTitle(text: "JoystickFolio", timeInterval: 0.1) { letter in
            self.titleLabel.text?.append(letter)
        }
    }
    
    func showSnackbar(with message: String) {
        DispatchQueue.main.async {
            AppSnackBar.make(in: self.view!, message: message, duration: .lengthLong).show()
        }
    }
}

//MARK: - UITextField
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
