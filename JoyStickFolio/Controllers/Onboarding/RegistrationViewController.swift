//
//  RegistrationViewController.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 03/12/2023.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    //MARK: - Managers
    private let authenticationManager = AuthenticationManager()
    
    //MARK: - Login Process
    private let processes:[RegistrationProcess]  = allProcesses
    private var index: Int = 0
    private var progressValue: Double = 0.0
    
    //MARK: - Classes
    private let validator = AuthValidator()
    private let animator = TextAnimator()
    
    //MARK: - Table
    private var data: [String : String] = [:]
    
    //MARK: - titleLabel
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.textAlignment = .center
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 30.0, weight: .regular)
        return label
    }()
    
    //MARK: - TextField
    private let textField: UITextField = {
        let field = UITextField()
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
    
    //MARK: - Second TextField
    private let secondTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password..."
        field.isSecureTextEntry = true
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
    
    //MARK: - Button
    private let submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .accent
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    //MARK: - progressBarView
    private let progressBarView: UIProgressView = {
        let progressBar = UIProgressView()
        progressBar.progress = 0.0
        progressBar.progressTintColor = .accent
        return progressBar
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        // add target to button
        submitButton.addTarget(self,
                               action: #selector(buttonPressed),
                               for: .touchUpInside)
        
        
        textField.placeholder = processes[index].placeholder
        submitButton.setTitle(processes[index].buttonTitle, for: .normal)
        titleLabel.text = processes[index].title
        
        progressBarView.progress = Float(progressValue)
        
        view.addSubview(progressBarView)
        view.addSubview(textField)
        view.addSubview(submitButton)
        view.addSubview(titleLabel)
        
        titleLabel.text? = ""
        animator.animateTitle(text: processes[index].title, timeInterval: 0.01) { letter in
            self.titleLabel.text?.append(letter)
            self.titleLabel.frame = CGRect(x: .zero,
                                           y: self.textField.top - 200,
                                           width: self.view.width,
                                           height: 150)
        }
    }
    
    //MARK: - viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        progressBarView.frame = CGRect(x: (view.width / 2) - ((view.width * 0.8) / 2),
                                       y: view.top + 60,
                                       width: view.width * 0.8,
                                       height: 10)
        
        
        titleLabel.frame = CGRect(x: .zero,
                                  y: textField.top - 200,
                                  width: view.width - 10,
                                  height: 150)
        
        
        textField.frame = CGRect(x: 25,
                                 y: (view.height / 2) - 70,
                                 width: view.width - 50,
                                 height: 52)
        
        
        secondTextField.frame = CGRect(x: 25,
                                 y: textField.top - 62,
                                 width: view.width - 50,
                                 height: 52)
        
        submitButton.frame = CGRect(x: 25,
                                    y: textField.bottom + 10,
                                    width: view.width - 50,
                                    height: 52)
        
        activityIndicator.center = view.center
    }
    
    //MARK: - Button Pressed
    @objc private func buttonPressed() {
        
        if processes.last != processes[index] {
            
            switch processes[index].process {
                
            case .enterFullName:
                guard validator.isFullNameValid(textField: textField.text ?? "") else {
                    AppSnackBar.make(in: self.view, message: "Invalid name", duration: .lengthLong).show()
                    return
                }
                data[Constants.Key.Auth.fullName] = textField.text ?? ""
                
                textField.text = ""
                break
            case .enterEmail:
                guard validator.isEmailValid(textField: textField.text ?? "") else {
                    AppSnackBar.make(in: self.view, message: "Invalid email", duration: .lengthLong).show()
                    return
                }
                
                data[Constants.Key.Auth.email] = textField.text ?? ""
                textField.text = ""
                break
            case .enterUsername:
                guard validator.isUsernameValid(textField: textField.text ?? "") else {
                    AppSnackBar.make(in: self.view, message: "Invalid username, should be between 4 and 20, no special characters, and no spaces", duration: .lengthLong).show()
                    return
                }
                
                data[Constants.Key.Auth.username] = textField.text ?? ""
                
                view.addSubview(secondTextField)
                secondTextField.becomeFirstResponder()
                textField.isSecureTextEntry = true
                textField.text = ""
            case .enterPassword:
               
                guard validator.isPasswordValid(textfield: textField.text ?? "", repearTextField: secondTextField.text ?? "") else {
                    AppSnackBar.make(in: self.view, message: "Invalid password, minimum length: 6 characters", duration: .lengthLong).show()
                    return
                }
                
                // deselect textfields
                secondTextField.resignFirstResponder()
                textField.resignFirstResponder()
                
                // remove views
                textField.removeFromSuperview()
                secondTextField.removeFromSuperview()
                submitButton.removeFromSuperview()
                
                data[Constants.Key.Auth.password] = textField.text ?? ""
                textField.text = ""
                
                registerUser(userInfo: data)

                view.addSubview(activityIndicator)
                activityIndicator.startAnimating()
            case .loading:
                break
            }

            
            index += 1
            progressValue += 1.0 / Double(processes.count - 1)
            
            textField.placeholder = processes[index].placeholder
            submitButton.setTitle(processes[index].buttonTitle, for: .normal)
            titleLabel.text = processes[index].title
            
            progressBarView.progress = Float(progressValue)
            
            titleLabel.text? = ""
            animator.animateTitle(text: processes[index].title, timeInterval: 0.01) { letter in
                self.titleLabel.text?.append(letter)
                self.titleLabel.frame = CGRect(x: .zero,
                                               y: self.textField.top - 200,
                                               width: self.view.width,
                                               height: 150)
            }
        }
    }
    
    //MARK: - registerUser
    private func registerUser(userInfo: [String : String]) {
        authenticationManager.createUser(with: userInfo)
    }
}
