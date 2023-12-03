//
//  LoginViewController.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 03/12/2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - Username Field
    private let usernameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = 8.0
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
        field.layer.cornerRadius = 8.0
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8.0
        button.backgroundColor = .accent
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    //MARK: - Header
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        
        header.backgroundColor = .purpleApp
        // Create the gradient layer
//        let gradient = CAGradientLayer()
//        gradient.frame = header.bounds
//        gradient.colors = [UIColor.black.cgColor, UIColor.red.cgColor]
//        
//        header.layer.addSublayer(gradient)
        
        return header
    }()

    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(self,
                              action: #selector(didTapLoginButton),
                              for: .touchUpInside)
        
        view.addSubview(headerView)
        view.addSubview(usernameField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        // Do any additional setup after loading the view.
    }
    
    //MARK: - ViewDidLayoutSubViews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerView.frame = CGRect(x: 0,
                                  y: 0.0,
                                  width: view.width,
                                  height: view.height / 3.0)
        
        usernameField.frame = CGRect(x: 25,
                                     y: headerView.bottom + 40,
                                     width: view.width - 50,
                                     height: 52)
        
        passwordField.frame = CGRect(x: 25,
                                     y: usernameField.bottom + 15,
                                     width: view.width - 50,
                                     height: 52)
        
        loginButton.frame = CGRect(x: 25,
                                   y: passwordField.bottom + 10,
                                   width: view.width - 50,
                                   height: 52)
        
    }
    
    @objc private func didTapLoginButton() {
        
    }
}


extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == usernameField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField{
            didTapLoginButton()
        }
        return true
    }
}
