//
//  LoginViewController.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 03/12/2023.
//

import UIKit
import RxSwift


class LoginViewController: UIViewController {
    
    //MARK: - Managers
    private let viewModel = LoginViewModel()
    
    //MARK: - Dispose Bag
    private let bag = DisposeBag()
    
    //MARK: - Animator
    private let animator = TextAnimator()
    
    //MARK: - Username Field
    private let usernameEmailField: UITextField = {
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
        return field
    }()
    
    //MARK: - Password Field
    private let passwordField: UITextField = {
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
        return field
    }()
    
    //MARK: - Login Button
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .accent
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    //MARK: - Create Account Button
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create an account?", for: .normal)
        button.layer.masksToBounds = true
        button.setTitleColor(.label , for: .normal)
        return button
    }()
    
    //MARK: - Header
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        return header
    }()
    
    //MARK: - Gradien Layer
    private let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.purpleApp.cgColor, UIColor.pinkApp.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        return gradient
    }()
    
    //MARK: - titleLabel
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 50.0)
        return label
    }()
    
    //MARK: - activityIndicator
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - Add Targets (Buttons)
        loginButton.addTarget(self,
                              action: #selector(didTapLoginButton),
                              for: .touchUpInside)
        
        createAccountButton.addTarget(self,
                                      action: #selector(didTapCreateAccountButton),
                                      for: .touchUpInside)
        
        //MARK: - Add Subviews
       addMainSubviews()
        
        //MARK: - Add Subviews to Header
        gradientLayer.frame = headerView.bounds
        headerView.layer.addSublayer(gradientLayer)
        headerView.addSubview(titleLabel)
        
        titleLabel.text = ""
        animator.animateTitle(text: "JoystickFolio", timeInterval: 0.1) { letter in
            self.titleLabel.text?.append(letter)
            self.titleLabel.frame = CGRect(x: .zero,
                                           y: self.view.top,
                                           width: self.headerView.width,
                                           height: self.headerView.height)
        }
    }
    
    //MARK: - ViewDidLayoutSubViews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerView.frame = CGRect(x: 0,
                                  y: 0.0,
                                  width: view.width,
                                  height: view.height / 3.0)
        
        headerView.layer.sublayers?.first?.frame = headerView.bounds
        
        usernameEmailField.frame = CGRect(x: 25,
                                          y: headerView.bottom + 40,
                                          width: view.width - 50,
                                          height: 52)
        
        passwordField.frame = CGRect(x: 25,
                                     y: usernameEmailField.bottom + 15,
                                     width: view.width - 50,
                                     height: 52)
        
        loginButton.frame = CGRect(x: 25,
                                   y: passwordField.bottom + 10,
                                   width: view.width - 50,
                                   height: 52)
        
        createAccountButton.frame = CGRect(x: 25,
                                           y: loginButton.bottom + 10,
                                           width: view.width - 50,
                                           height: 52)
        
        activityIndicator.center = view.center
        
    }
    
    
    //MARK: - didTapCreateAccountButton
    @objc private func didTapCreateAccountButton() {
        let vc = RegistrationViewController()
        vc.title = "Create Account"
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    //MARK: - didTapLoginButton
    @objc private func didTapLoginButton() {
        showLoading()
        Task {
            do {
                try await viewModel.signIn(usernameEmail: usernameEmailField.text ?? "", password: passwordField.text ?? "")
                    .subscribe(onError: { [weak self] error in
                        self?.hideLoading()
                        self?.showSnackbar(with: error.localizedDescription)
                        
                    }, onCompleted: {
                        
                        self.viewModel.requestIDFA()
                        
                        AnalyticsManager.logEvent(event: .login)
                        
                        DispatchQueue.main.async{
                            
                            self.dismiss(animated: true, completion: nil)
                        }
                    })
                    .disposed(by: bag)
                
            } catch {
                hideLoading()
                showSnackbar(with: error.localizedDescription)
            }
            
        }
    }
    
    //MARK: - addMainSubviews
    private func addMainSubviews() {
        DispatchQueue.main.async {
            self.view.addSubview(self.headerView)
            self.view.addSubview(self.usernameEmailField)
            self.view.addSubview(self.passwordField)
            self.view.addSubview(self.loginButton)
            self.view.addSubview(self.createAccountButton)
        }
    }
    
    //MARK: - showSnackbar
    private func showSnackbar(with message: String) {
        DispatchQueue.main.async {
            AppSnackBar.make(in: self.view!, message: message, duration: .lengthLong).show()
        }
    }
    
    //MARK: - showLoading
    private func showLoading() {
        usernameEmailField.removeFromSuperview()
        passwordField.removeFromSuperview()
        loginButton.removeFromSuperview()
        createAccountButton.removeFromSuperview()
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    //MARK: - hideLoading
    private func hideLoading() {
        DispatchQueue.main.async {
            self.addMainSubviews()
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        }
    }
}

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
