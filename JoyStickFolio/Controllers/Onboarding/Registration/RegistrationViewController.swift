//
//  RegistrationViewController.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 03/12/2023.
//

import UIKit
import RxSwift
import FirebaseAnalytics

class RegistrationViewController: UIViewController {
    
    //MARK: - viewModel
    private let viewModel = RegistrationViewModel()
    
    //MARK: - Animator
    private let animator = TextAnimator()
    
    //MARK: - Dispose Bag
    private let bag = DisposeBag()
    
    //MARK: - dismissalCompletion
    var dismissalCompletion: (() -> Void)?
    
    //MARK: - Login Process
    let processes:[RegistrationProcess]  = allProcesses
    var index: Int = 0
    var progressValue: Double = 0.0
    
    
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
        field.textContentType = .name
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
    
    //MARK: - activityIndicator
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
        Task {
            
            if processes.last != processes[index] {
                
                switch processes[index].process {
                    
                    //MARK: - enterFullName
                case .enterFullName:
                    guard viewModel.isFullNameValid(textField: textField.text ?? "") else {
                        AppSnackBar.make(in: self.view, message: "Invalid name", duration: .lengthLong).show()
                        return
                    }
                    
                    viewModel.fullNameEntered(fullName: textField.text ?? "")
                    textField.textContentType = .emailAddress
                    textField.text = ""
                    break
                    
                    //MARK: - enterEmail
                case .enterEmail:
                    guard viewModel.isEmailValid(textField: textField.text ?? "") else {
                        AppSnackBar.make(in: self.view, message: "Invalid email", duration: .lengthLong).show()
                        return
                    }
                    
                    viewModel.emailEntered(email: textField.text ?? "")
                    textField.textContentType = .name
                    textField.text = ""
                    break
                    
                    //MARK: - enterUsername
                case .enterUsername:
                    
                    guard viewModel.isUsernameValid(textField: textField.text ?? "") else {
                        AppSnackBar.make(in: self.view, message: "Invalid username, should be between 4 and 20, no special characters, and no spaces", duration: .lengthLong).show()
                        return
                    }
                    addLoadingIndicator()
                    
                    guard await viewModel.isUsernameAvailble(username: textField.text ?? "") else {
                        AppSnackBar.make(in: self.view, message: "Username already taken", duration: .lengthLong).show()
                        removeLoadingIndicator()
                        return
                    }
                    
                    
                    removeLoadingIndicator()
                    textField.textContentType = .newPassword
                    usernameEntered(username: textField.text ?? "")
                    
                    
                    //MARK: - enterPassword
                case .enterPassword:
                    
                    guard viewModel.isPasswordValid(textfield: textField.text ?? "", repeatTextField: secondTextField.text ?? "") else {
                        AppSnackBar.make(in: self.view, message: "Passwords should match and have a minimum length of 6 characters", duration: .lengthLong).show()
                        return
                    }
                    
                    passwordEntered(password: textField.text ?? "")
                    
                    //MARK: - loading
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
    }
    
    //MARK: - usernameEntered
    private func usernameEntered(username: String) {
        viewModel.usernameEntered(username: username)
        view.addSubview(secondTextField)
        secondTextField.becomeFirstResponder()
        textField.isSecureTextEntry = true
        textField.text = ""
    }
    
    //MARK: - passwordEntered
    private func passwordEntered(password: String) {
        
        // deselect textfields
        secondTextField.resignFirstResponder()
        textField.resignFirstResponder()
        
        
        textField.isSecureTextEntry = false
        textField.text = ""
        secondTextField.text = ""
        
        
        // remove views
        textField.removeFromSuperview()
        secondTextField.removeFromSuperview()
        submitButton.removeFromSuperview()
        progressBarView.removeFromSuperview()
        
        addLoadingIndicator()
        
        viewModel.passwordEntered(password: password)
        
        Task{
            await viewModel.registerUser()
                .subscribe(onError: { [weak self] error in
                    
                    self?.resetRegistration()
                    AppSnackBar.make(in: self!.view!, message: error.localizedDescription, duration: .lengthLong).show()
                    
                }, onCompleted: {
                    AnalyticsManager.logEvent(event: .signup)
                    DispatchQueue.main.async{
                        self.dismiss(animated: true) {
                            self.dismissalCompletion?()
                        }
                    }
                })
                .disposed(by: bag)
        }
        
    }
    
    //MARK: - resetRegistration
    private func resetRegistration() {
        viewModel.data = [:]
        progressValue = 0
        index = 0
        
        removeLoadingIndicator()
        
        textField.placeholder = processes[index].placeholder
        submitButton.setTitle(processes[index].buttonTitle, for: .normal)
        titleLabel.text = processes[index].title
        
        progressBarView.progress = Float(progressValue)
        
        view.addSubview(progressBarView)
        view.addSubview(textField)
        view.addSubview(submitButton)
        
    }
    
    //MARK: - addLoadingIndicator
    private func addLoadingIndicator() {
        isModalInPresentation = true
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    //MARK: - removeLoadingIndicator
    private func removeLoadingIndicator() {
        isModalInPresentation = false
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
}
