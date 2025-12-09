//
//  RegisterController.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 11.11.25.
//

import UIKit

class RegisterController: BaseController {

    private lazy var usernameContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "textBackground")
        view.layer.cornerRadius = 24
        view.layer.borderColor = UIColor(named: "textBorderColor")?.cgColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var usernameTextField: UITextField = {
        let t = UITextField()
        t.placeholder = "Enter your name"
        t.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private lazy var usernameImage: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(systemName: "person")
        i.tintColor = UIColor(named: "placeholderColor")
        i.contentMode = .scaleAspectFill
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "textBackground")
        view.layer.cornerRadius = 24
        view.layer.borderColor = UIColor(named: "textBorderColor")?.cgColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var emailTextField: UITextField = {
        let t = UITextField()
        t.placeholder = "Enter your email"
        t.keyboardType = .emailAddress
        t.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private lazy var emailImage: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(systemName: "envelope")
        i.contentMode = .scaleAspectFill
        i.tintColor = UIColor(named: "placeholderColor")
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "textBackground")
        view.layer.cornerRadius = 24
        view.layer.borderColor = UIColor(named: "textBorderColor")?.cgColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var passwordTextField: UITextField = {
        let t = UITextField()
        t.placeholder = "Enter your password"
        t.isSecureTextEntry = true
        t.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        t.translatesAutoresizingMaskIntoConstraints = false
        
        return t
    }()
    
    private lazy var passwordImage: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(systemName: "lock")
        i.contentMode = .scaleAspectFill
        i.tintColor = UIColor(named: "placeholderColor")
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var visibilityButton: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        b.addTarget(self, action: #selector(changeVisibility), for: .touchUpInside)
        b.tintColor = UIColor(named: "placeholderColor")
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    private lazy var privacyLabel: UILabel = {
        let l = UILabel()
        l.textColor = UIColor(named: "placeholderColor")
        l.numberOfLines = 0
        l.font = .systemFont(ofSize: 13, weight: .regular)
        l.text = "I agree to the medidoc Terms of Service and Privacy Policy"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var checkBox: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(systemName: "square"), for: .normal)
        b.addTarget(self, action: #selector(changeCheckBox), for: .touchUpInside)
        b.tintColor = UIColor(named: "placeholderColor")
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = GradientButton()
        button.setTitle("Sign Up", for: .normal)
        button.gradientColors = [UIColor(named: "buttonStart") ?? .gray,
                                 UIColor(named: "buttonEnd") ?? .gray]
        button.tintColor = .white
        button.startPoint = CGPoint(x: 0, y: 0)
        button.endPoint = CGPoint(x: 1, y: 1)
        button.corner = 30
        button.isEnabled = false
        button.alpha = 0.6
        button.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var questionLabel: UILabel = {
        let l = UILabel()
        l.textColor = UIColor(named: "placeholderColor")
        l.numberOfLines = 0
        l.font = .systemFont(ofSize: 15, weight: .regular)
        l.text = "Already Have an Account?"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var signInButton: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        b.setTitle("Sign In", for: .normal)
        b.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        b.setTitleColor(UIColor(named: "buttonStart"), for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    private let viewModel: RegisterViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(vm: RegisterViewModel) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configUI() {
        self.title = "Sign Up"
        view.backgroundColor = .systemBackground
    }
    
    override func configConstraint() {
        [usernameContainerView, emailContainerView, passwordContainerView, checkBox, privacyLabel, signUpButton, questionLabel, signInButton].forEach { view in
            self.view.addSubview(view)
        }
        [usernameImage, usernameTextField].forEach { view in
            usernameContainerView.addSubview(view)
        }
        [emailImage, emailTextField].forEach { view in
            emailContainerView.addSubview(view)
        }
        [passwordImage, passwordTextField, visibilityButton].forEach { view in
            passwordContainerView.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            usernameContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                       constant: 24),
            usernameContainerView.leadingAnchor.constraint(equalTo:
                                                            view.leadingAnchor,
                                                           constant: 24),
            usernameContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                            constant: -24),
            usernameContainerView.heightAnchor.constraint(equalToConstant: 56),
            
            usernameImage.centerYAnchor.constraint(equalTo: usernameContainerView.centerYAnchor),
            usernameImage.leadingAnchor.constraint(equalTo: usernameContainerView.leadingAnchor, constant: 24),
            usernameImage.widthAnchor.constraint(equalToConstant: 24),
            usernameImage.heightAnchor.constraint(equalToConstant: 24),
            
            usernameTextField.centerYAnchor.constraint(equalTo: usernameContainerView.centerYAnchor),
            usernameTextField.leadingAnchor.constraint(equalTo: usernameImage.trailingAnchor, constant: 16),
            
            emailContainerView.topAnchor.constraint(equalTo: usernameContainerView.bottomAnchor,
                                                    constant: 16),
            emailContainerView.leadingAnchor.constraint(equalTo:
                                                            usernameContainerView.leadingAnchor),
            emailContainerView.trailingAnchor.constraint(equalTo: usernameContainerView.trailingAnchor),
            emailContainerView.heightAnchor.constraint(equalToConstant: 56),
            
            emailImage.centerYAnchor.constraint(equalTo: emailContainerView.centerYAnchor),
            emailImage.leadingAnchor.constraint(equalTo: emailContainerView.leadingAnchor, constant: 24),
            emailImage.widthAnchor.constraint(equalToConstant: 24),
            emailImage.heightAnchor.constraint(equalToConstant: 24),
            
            emailTextField.centerYAnchor.constraint(equalTo: emailContainerView.centerYAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: emailImage.trailingAnchor, constant: 16),
            
            passwordContainerView.topAnchor.constraint(equalTo: emailContainerView.bottomAnchor,
                                                       constant: 16),
            passwordContainerView.leadingAnchor.constraint(equalTo:
                                                            emailContainerView.leadingAnchor),
            passwordContainerView.trailingAnchor.constraint(equalTo: emailContainerView.trailingAnchor),
            passwordContainerView.heightAnchor.constraint(equalToConstant: 56),
            
            passwordImage.centerYAnchor.constraint(equalTo: passwordContainerView.centerYAnchor),
            passwordImage.leadingAnchor.constraint(equalTo: passwordContainerView.leadingAnchor, constant: 24),
            passwordImage.widthAnchor.constraint(equalToConstant: 24),
            passwordImage.heightAnchor.constraint(equalToConstant: 24),
            
            visibilityButton.centerYAnchor.constraint(equalTo: passwordContainerView.centerYAnchor),
            visibilityButton.trailingAnchor.constraint(equalTo: passwordContainerView.trailingAnchor, constant: -24),
            visibilityButton.widthAnchor.constraint(equalToConstant: 24),
            visibilityButton.heightAnchor.constraint(equalToConstant: 24),
            
            passwordTextField.centerYAnchor.constraint(equalTo: passwordContainerView.centerYAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordImage.trailingAnchor, constant: 16),
            
            checkBox.leadingAnchor.constraint(equalTo: passwordContainerView.leadingAnchor),
            checkBox.topAnchor.constraint(equalTo: passwordContainerView.bottomAnchor, constant: 16),
            checkBox.widthAnchor.constraint(equalToConstant: 24),
            checkBox.heightAnchor.constraint(equalToConstant: 24),
            
            privacyLabel.trailingAnchor.constraint(equalTo: passwordContainerView.trailingAnchor),
            privacyLabel.topAnchor.constraint(equalTo: passwordContainerView.bottomAnchor, constant: 16),
            privacyLabel.leadingAnchor.constraint(equalTo: checkBox.trailingAnchor, constant: 16),
            
            signUpButton.leadingAnchor.constraint(equalTo: passwordContainerView.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: passwordContainerView.trailingAnchor),
            signUpButton.topAnchor.constraint(equalTo: privacyLabel.bottomAnchor, constant: 32),
            signUpButton.heightAnchor.constraint(equalToConstant: 56),
            
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 69),
            questionLabel.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 24),
            
            signInButton.leadingAnchor.constraint(equalTo: questionLabel.trailingAnchor, constant: 5),
            signInButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 24),
            signInButton.centerYAnchor.constraint(equalTo: questionLabel.centerYAnchor)
            
        ])
    }
    
    @objc func changeVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        passwordTextField.isSecureTextEntry ? visibilityButton.setImage(UIImage(systemName: "eye.slash"), for: .normal) : visibilityButton.setImage(UIImage(systemName: "eye"), for: .normal)
    }
    
    @objc func changeCheckBox() {
        checkBox.isSelected.toggle()
        if checkBox.isSelected {
            if ((usernameTextField.text != "") && (emailTextField.text != "") && (passwordTextField.text != "")) {
                signUpButton.isEnabled = true
                signUpButton.alpha = 1
            }
            
            checkBox.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            checkBox.tintColor = UIColor(named: "success")
        } else {
            signUpButton.isEnabled = false
            signUpButton.alpha = 0.6
            
            checkBox.setImage(UIImage(systemName: "square"), for: .normal)
            checkBox.tintColor = UIColor(named: "placeholderColor")
        }
    }
    
    @objc func signUp() {
        let username = (usernameTextField.text ?? "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
        let email = (emailTextField.text ?? "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
        let password = (passwordTextField.text ?? "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        viewModel.register(username: username, email: email, password: password)
    }
    
    override func configVM() {
        viewModel.completion = { [weak self] viewState in
            switch viewState {
            case .success(_):
                let coordinator = StatusCoordinator(navigationController: self?.navigationController ?? UINavigationController(), configFor: .register)
                coordinator.start()
            case .error(let error):
                print(error)
                let coordinator = StatusCoordinator(navigationController: self?.navigationController ?? UINavigationController(), configFor: .error(error: error))
                coordinator.start()
            }
        }
    }
    
    @objc func signIn() {
        let coordinator = LoginCoordinator(navigationController: self.navigationController ?? UINavigationController(), vc: self)
        coordinator.start()
    }
    
    @objc func textFieldEditingChanged(_ sender: UITextField) {
        let enabled = UIColor(named: "buttonStart")
        let disabled = UIColor(named: "placeholderColor")
        
        if sender.text == "" {
            signUpButton.isEnabled = false
            signUpButton.alpha = 0.6
            switch sender {
            case usernameTextField:
                usernameImage.tintColor = disabled
            case emailTextField:
                emailImage.tintColor = disabled
            case passwordTextField:
                passwordImage.tintColor = disabled
            default:
                break
            }
        } else {
            switch sender {
            case usernameTextField:
                usernameImage.tintColor = enabled
            case emailTextField:
                emailImage.tintColor = enabled
            case passwordTextField:
                passwordImage.tintColor = enabled
            default:
                break
            }
            if checkBox.isSelected && !(usernameTextField.text?.isEmpty ?? true) && !(emailTextField.text?.isEmpty ?? true) && !(passwordTextField.text?.isEmpty ?? true) {
                signUpButton.isEnabled = true
                signUpButton.alpha = 1
            }
        }
    }
}
