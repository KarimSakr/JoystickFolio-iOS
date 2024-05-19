//
//  RegistrationViewController.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 11/05/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import UIKit
import RxSwift

protocol RegistrationViewControllerOutput {
    func addData(to key: String, value: String)
    func isUsernameAvailable(username: String) async -> Bool
    func registerUser() async -> Single<Void>
    func resetData()
}

class RegistrationViewController: UIViewController {
    
    var interactor: RegistrationViewControllerOutput?
    var router: RegistrationRouter?
    
    var dismissalCompletion: (() -> Void)?
    
    fileprivate var disposeBag = DisposeBag()
    
    fileprivate var progressValue: Double = 0.0
    fileprivate var index : Int = 0
    
    fileprivate let processes:[RegistrationModels.ViewModels.RegistrationProcess] = [
        .init(title: "Well hello there!\nGot a name?", placeholder: "Full Name...", buttonTitle: "Next", process: .enterFullName),
        .init(title: "Nice to meet you!\nHow can we contact you?", placeholder: "Email...", buttonTitle: "Next", process: .enterEmail),
        .init(title: "How about a unique nickname?\nLike everybody else...", placeholder: "Username...", buttonTitle: "Next", process: .enterUsername),
        .init(title: "How about some privacy?\n No peeking...\nI promise :)", placeholder: "Confirm Password...", buttonTitle: "Submit", process: .enterPassword),
        .init(title: "Creating player...", placeholder: "", buttonTitle: "", process: .loading),
    ]
    
    //MARK: - titleLabel
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.textAlignment = .center
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 30.0, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - TextField
    lazy var mainTextField: UITextField = {
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
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    //MARK: - Second TextField
    lazy var secondTextField: UITextField = {
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
        field.isHidden = true
        field.textContentType = .newPassword
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    //MARK: - Button
    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .accent
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - progressBarView
    lazy var progressBarView: UIProgressView = {
        let progressBar = UIProgressView()
        progressBar.progress = 0.0
        progressBar.progressTintColor = .accent
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    }()
    
    //MARK: - activityIndicator
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
}

//MARK: - View Lifecycle -
extension RegistrationViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RegistrationConfigurator.shared.configure(viewController: self)
        view.backgroundColor = .systemBackground
        setupButton()
        setupViewsData()
        addUIViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateText()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([
            
            // Add constraints for progressBarView
            progressBarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            progressBarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressBarView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            progressBarView.heightAnchor.constraint(equalToConstant: 10),
            
            titleLabel.topAnchor.constraint(equalTo: progressBarView.bottomAnchor, constant: 40),
            titleLabel.widthAnchor.constraint(equalToConstant: 330),
            titleLabel.heightAnchor.constraint(equalToConstant: 150),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Add constraints for textField
            mainTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 70),
            mainTextField.widthAnchor.constraint(equalToConstant: 340),
            mainTextField.heightAnchor.constraint(equalToConstant: 52),

            // Add constraints for secondTextField
            secondTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            secondTextField.bottomAnchor.constraint(equalTo: mainTextField.topAnchor, constant: -10),
            secondTextField.widthAnchor.constraint(equalToConstant: 340),
            secondTextField.heightAnchor.constraint(equalToConstant: 52),
            
            // Add constraints for submitButton
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            submitButton.topAnchor.constraint(equalTo: mainTextField.bottomAnchor, constant: 10),
            submitButton.widthAnchor.constraint(equalToConstant: 340),
            submitButton.heightAnchor.constraint(equalToConstant: 52),
            
            // Add constraints for activityIndicator
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

//MARK: - Setup Functions -
extension RegistrationViewController {
    

    fileprivate
    func setupButton() {
        submitButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    fileprivate
    func setupViewsData() {
        mainTextField.placeholder = processes[index].placeholder
        submitButton.setTitle(processes[index].buttonTitle, for: .normal)
        titleLabel.text = processes[index].title
        progressBarView.progress = Float(progressValue)
    }
    
    fileprivate
    func addUIViews() {
        view.addSubview(progressBarView)
        view.addSubview(mainTextField)
        view.addSubview(secondTextField)
        view.addSubview(submitButton)
        view.addSubview(titleLabel)
        view.addSubview(activityIndicator)
    }
    
    fileprivate
    func animateText() {
        titleLabel.text? = ""
        TextAnimator.animateTitle(text: self.processes[index].title, timeInterval: 0.01) { letter in
            self.titleLabel.text?.append(letter)
        }
    }
}

//MARK: - Button Function -
extension RegistrationViewController {
    
    @objc fileprivate
    func buttonPressed() {
        
        var isSuccessful: Bool = false
        
        Task {

            if processes.last != processes[index] {

                switch processes[index].process {

                case .enterFullName:
                    isSuccessful = didEnterFullNameSuccessfully(fullName: mainTextField.text ?? "")

                case .enterEmail:
                    isSuccessful = didEnterEmailSuccessfully(email: mainTextField.text ?? "")

                case .enterUsername:
                    isModalInPresentation = true
                    isSuccessful = await didEnterUsernameSuccessfully(username: mainTextField.text ?? "")
                    isModalInPresentation = false
                    
                case .enterPassword:
                    isModalInPresentation = true
                    isSuccessful = await didEnterPasswordSuccessfully(password: mainTextField.text ?? "", repeatPassword: secondTextField.text ?? "")
                    isModalInPresentation = false
                    
                case .loading:
                    break
                }
                if isSuccessful{
                    nextEntry()
                }
            }
        }
    }
    
   
    
}

//MARK: - Indicator and SnackBar -
extension RegistrationViewController {
    fileprivate
    func addLoadingIndicator() {
        isModalInPresentation = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    fileprivate
    func removeLoadingIndicator() {
        isModalInPresentation = false
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    fileprivate
    func showError(with message: String) {
        AppSnackBar.make(in: self.view, message: message, duration: .lengthShort)
            .show()
    }
}

//MARK: - functions -
extension RegistrationViewController {
    
    fileprivate
    func didEnterFullNameSuccessfully(fullName: String) -> Bool {
        guard let interactor = interactor else {
            showError(with: "Something went wrong")
            return false
        }
        guard fullName.isFullNameValid() else {
            showError(with: "Invalid name")
            return false
        }
        interactor.addData(to: Constants.Key.Auth.fullName, value: fullName)
        fullNameEntered()
        return true
    }
    
    fileprivate
    func didEnterEmailSuccessfully(email: String) -> Bool {
        guard let interactor = interactor else {
            showError(with: "Something went wrong")
            return false
        }
        guard email.isEmail() else {
            showError(with: "Invalid email")
            return false
        }
        interactor.addData(to: Constants.Key.Auth.email, value: email)
        emailEntered()
        return true
    }
    
    fileprivate
    func didEnterUsernameSuccessfully(username: String) async -> Bool{
     
        guard let interactor = interactor else {
            showError(with: "Something went wrong")
            return false
        }
        guard username.isUsernameValid() else {
            showError(with: "Invalid username, should be between 4 and 20, no special characters, and no spaces")
            return false
        }
        
        addLoadingIndicator()
        
        guard await interactor.isUsernameAvailable(username: username) else {
            showError(with: "Username already taken")
            removeLoadingIndicator()
            return false
        }
        interactor.addData(to: Constants.Key.Auth.username, value: username)
        usernameEntered()
        return true
    }
    
    fileprivate
    func didEnterPasswordSuccessfully(password: String, repeatPassword: String) async -> Bool {
        guard let interactor = interactor else {
            showError(with: "Something went wrong")
            return false
        }
        guard password.isPasswordValid(), password.isPasswordValid(repeatTextField: repeatPassword) else {
            showError(with: "Passwords should match and have a minimum length of 6 characters")
            return false
        }
        interactor.addData(to: Constants.Key.Auth.password, value: password)
        passwordEntered()
        nextEntry()
        await interactor.registerUser()
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.dismiss(animated: false) {
                    self.dismissalCompletion?()
                }
            } onFailure: { [weak self] error in
                guard let self = self else { return }
                resetRegistration()
                self.showError(with: error.localizedDescription)
            }.disposed(by: disposeBag)

        
        return false
    }
    
    fileprivate
    func resetRegistration() {
        progressValue = 0
        index = 0
        resetRegistrationUI()
    }
}

//MARK: - UI Functions -
extension RegistrationViewController {
    fileprivate
    func fullNameEntered() {
        DispatchQueue.main.async {
            self.mainTextField.textContentType = .emailAddress
            self.mainTextField.text = ""
        }
    }
    
    fileprivate
    func emailEntered() {
        DispatchQueue.main.async { [self] in
            mainTextField.textContentType = .name
            mainTextField.text = ""
        }
    }
    
    fileprivate
    func usernameEntered() {
        DispatchQueue.main.async { [self] in
            secondTextField.isHidden = false
            secondTextField.becomeFirstResponder()
            mainTextField.isSecureTextEntry = true
            mainTextField.text = ""
            removeLoadingIndicator()
            mainTextField.textContentType = .newPassword
        }
    }
    
    fileprivate
    func passwordEntered() {
     
        DispatchQueue.main.async { [self] in
            // deselect textfields
            secondTextField.resignFirstResponder()
            mainTextField.resignFirstResponder()
            mainTextField.isSecureTextEntry = false
            mainTextField.text = ""
            secondTextField.text = ""
            
            // remove views
            mainTextField.isHidden   = true
            secondTextField.isHidden = true
            submitButton.isHidden    = true
            progressBarView.isHidden = true
            
            addLoadingIndicator()
        }
    }
    
    fileprivate
    func resetRegistrationUI() {
        
        DispatchQueue.main.async { [self] in
            removeLoadingIndicator()
            mainTextField.placeholder = processes[index].placeholder
            submitButton.setTitle(processes[index].buttonTitle, for: .normal)
            titleLabel.text = processes[index].title
            progressBarView.progress = Float(0)
            progressBarView.isHidden = false
            mainTextField.isHidden   = false
            submitButton.isHidden    = false
        }
    }
    
    fileprivate
    func nextEntry() {
        index += 1
        progressValue += 1.0 / Double(processes.count - 1)
        
        DispatchQueue.main.async { [self] in
            mainTextField.placeholder = processes[index].placeholder
            submitButton.setTitle(processes[index].buttonTitle, for: .normal)
            
            progressBarView.progress = Float(progressValue)
            titleLabel.text? = ""
        }
        
        
        TextAnimator.animateTitle(text: processes[index].title, timeInterval: 0.01) { letter in
            DispatchQueue.main.async {
                self.titleLabel.text?.append(letter)
            }
        }
    }
}

//MARK: - UITextFieldDelegate -
extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == mainTextField {
            buttonPressed()
        } else if textField == secondTextField {
            self.mainTextField.becomeFirstResponder()
        }
        
        return true
    }
}
