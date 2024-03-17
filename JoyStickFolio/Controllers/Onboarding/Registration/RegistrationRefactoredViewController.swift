//
//  RegistrationViewController.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 14/03/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import RxSwift
import FirebaseAnalytics

protocol RegistrationDisplayLogic: AnyObject {
    
}

class RegistrationViewController: UIViewController, RegistrationDisplayLogic {
    
    var interactor: RegistrationBusinessLogic?
  var router: RegistrationRouter?
    
    private let animator = TextAnimator()
    
    private let bag = DisposeBag()
    
    var dismissalCompletion: (() -> Void)?
    


    private var index: Int = 0
    private var progressValue: Double = 0.0
    
    
    //MARK: - titleLabel
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.textAlignment = .center
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 30.0, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - TextField
    private lazy var textField: UITextField = {
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
    private lazy var secondTextField: UITextField = {
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
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    //MARK: - Button
    private lazy var submitButton: UIButton = {
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
    private lazy var progressBarView: UIProgressView = {
        let progressBar = UIProgressView()
        progressBar.progress = 0.0
        progressBar.progressTintColor = .accent
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    }()
    
    //MARK: - activityIndicator
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
}

// MARK: View lifecycle
extension RegistrationViewController {
    
    override func viewDidLoad() {
      super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setup()
        setupButton()
        setupViewsData()
        addUIViews()
        animateText()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Add constraints for progressBarView
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
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 70),
            textField.widthAnchor.constraint(equalToConstant: 340),
            textField.heightAnchor.constraint(equalToConstant: 52),

            // Add constraints for secondTextField
            secondTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            secondTextField.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -10),
            secondTextField.widthAnchor.constraint(equalToConstant: 340),
            secondTextField.heightAnchor.constraint(equalToConstant: 52),
            
            // Add constraints for submitButton
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            submitButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            submitButton.widthAnchor.constraint(equalToConstant: 340),
            submitButton.heightAnchor.constraint(equalToConstant: 52),
            
            // Add constraints for activityIndicator
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

//MARK: - setup
extension RegistrationViewController {
    
    private func setup() {
        let viewController = self
        let interactor = RegistrationInteractor()
        let presenter = RegistrationPresenter()
        let router = RegistrationRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    

    func setupButton() {
        submitButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    func setupViewsData() {
        textField.placeholder = interactor!.processes[index].placeholder
        submitButton.setTitle(interactor!.processes[index].buttonTitle, for: .normal)
        titleLabel.text = interactor!.processes[index].title
        progressBarView.progress = Float(progressValue)
    }
    
    func addUIViews() {
        view.addSubview(progressBarView)
        view.addSubview(textField)
        view.addSubview(secondTextField)
        view.addSubview(submitButton)
        view.addSubview(titleLabel)
        view.addSubview(activityIndicator)
    }
    
    
    func animateText() {
        titleLabel.text? = ""
        self.animator.animateTitle(text: self.interactor!.processes[self.index].title, timeInterval: 0.01) { letter in
            self.titleLabel.text?.append(letter)
            
        }
    }
}

//MARK: - functions
extension RegistrationViewController {
    
    @objc private func buttonPressed() {
        Task {

            if interactor!.processes.last != interactor!.processes[index] {

                switch interactor!.processes[index].process {

                case .enterFullName:
                    guard interactor!.isFullNameValid(textField: textField.text ?? "") else {
                        AppSnackBar.make(in: self.view, message: "Invalid name", duration: .lengthLong).show()
                        return
                    }

                    interactor!.fullNameEntered(fullName: textField.text ?? "")
                    textField.textContentType = .emailAddress
                    textField.text = ""
                    break

                case .enterEmail:
                    guard interactor!.isEmailValid(textField: textField.text ?? "") else {
                        AppSnackBar.make(in: self.view, message: "Invalid email", duration: .lengthLong).show()
                        return
                    }

                    interactor!.emailEntered(email: textField.text ?? "")
                    textField.textContentType = .name
                    textField.text = ""
                    break

                case .enterUsername:

                    guard interactor!.isUsernameValid(textField: textField.text ?? "") else {
                        AppSnackBar.make(in: self.view, message: "Invalid username, should be between 4 and 20, no special characters, and no spaces", duration: .lengthLong).show()
                        return
                    }
                    addLoadingIndicator()

                    guard await interactor!.isUsernameAvailble(username: textField.text ?? "") else {
                        AppSnackBar.make(in: self.view, message: "Username already taken", duration: .lengthLong).show()
                        removeLoadingIndicator()
                        return
                    }


                    removeLoadingIndicator()
                    textField.textContentType = .newPassword
                    usernameEntered(username: textField.text ?? "")


                case .enterPassword:

                    guard interactor!.isPasswordValid(textfield: textField.text ?? "", repeatTextField: secondTextField.text ?? "") else {
                        AppSnackBar.make(in: self.view, message: "Passwords should match and have a minimum length of 6 characters", duration: .lengthLong).show()
                        return
                    }

                    passwordEntered()

                case .loading:
                    break
                }


                index += 1
                progressValue += 1.0 / Double(interactor!.processes.count - 1)

                textField.placeholder = interactor!.processes[index].placeholder
                submitButton.setTitle(interactor!.processes[index].buttonTitle, for: .normal)
                titleLabel.text = interactor!.processes[index].title

                progressBarView.progress = Float(progressValue)

                titleLabel.text? = ""
                animator.animateTitle(text: interactor!.processes[index].title, timeInterval: 0.01) { letter in
                    self.titleLabel.text?.append(letter)
                }
            }
        }
    }
    
    private func usernameEntered(username: String) {
        interactor!.usernameEntered(username: username)
        secondTextField.isHidden = false
        secondTextField.becomeFirstResponder()
        textField.isSecureTextEntry = true
        textField.text = ""
    }
    
    private func passwordEntered() {
        
        interactor!.passwordEntered(password: textField.text ?? "")
        
        // deselect textfields
        secondTextField.resignFirstResponder()
        textField.resignFirstResponder()
        
        
        textField.isSecureTextEntry = false
        textField.text = ""
        secondTextField.text = ""
        
        
        // remove views
        textField.isHidden       = true
        secondTextField.isHidden = true
        submitButton.isHidden    = true
        progressBarView.isHidden = true
        
        addLoadingIndicator()
        
        Task{
            await interactor!.registerUser()
                .subscribe { [weak self] event in
                    
                    guard let self = self else { return }
                    switch event {
                        
                    case .success():
                        AnalyticsManager.logEvent(event: .signup)
                        DispatchQueue.main.async{
                            self.dismiss(animated: false) {
                                self.dismissalCompletion?()
                            }
                        }
                    case .failure(let error):
                        self.resetRegistration()
                        AppSnackBar.make(in: self.view!, message: error.localizedDescription, duration: .lengthLong).show()
                    }
                    
                }.disposed(by: bag)
        }
        
    }
    
    func resetRegistration() {
        interactor!.data = [:]
        progressValue = 0
        index = 0
        
        removeLoadingIndicator()
        
        textField.placeholder = interactor!.processes[index].placeholder
        submitButton.setTitle(interactor!.processes[index].buttonTitle, for: .normal)
        titleLabel.text = interactor!.processes[index].title
        
        progressBarView.progress = Float(progressValue)
        
        progressBarView.isHidden = false
        textField.isHidden       = false
        submitButton.isHidden    = false
        
    }
    
    func addLoadingIndicator() {
        isModalInPresentation = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func removeLoadingIndicator() {
        isModalInPresentation = false
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}
