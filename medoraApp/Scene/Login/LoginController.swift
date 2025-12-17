//
//  LoginController.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 11.11.25.
//

import UIKit

class LoginController: BaseController {

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
    
    private lazy var signInButton: UIButton = {
        let button = GradientButton()
        button.setTitle("Login", for: .normal)
        button.gradientColors = [UIColor(named: "buttonStart") ?? .gray,
                                 UIColor(named: "buttonEnd") ?? .gray]
        button.tintColor = .white
        button.startPoint = CGPoint(x: 0, y: 0)
        button.endPoint = CGPoint(x: 1, y: 1)
        button.corner = 30
        button.isEnabled = false
        button.alpha = 0.6
        button.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var questionLabel: UILabel = {
        let l = UILabel()
        l.textColor = UIColor(named: "placeholderColor")
        l.numberOfLines = 0
        l.font = .systemFont(ofSize: 15, weight: .regular)
       // l.text = "Don’t have an account?"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var signUpButton: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
      //  b.setTitle("Sign Up", for: .normal)
        b.addTarget(self, action: #selector(signUp), for: .touchUpInside)
      //  b.setTitleColor(UIColor(named: "buttonStart"), for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    private lazy var appleContainerView: ContanierView = {
        let appleContainerView = ContanierView(image: "ios", title: "Sign in with Apple", configForScreen: .login)
        appleContainerView.layer.cornerRadius = 24
        appleContainerView.layer.borderColor = UIColor(named: "textBorderColor")?.cgColor
        appleContainerView.layer.borderWidth = 1
        appleContainerView.translatesAutoresizingMaskIntoConstraints = false
        return appleContainerView
    }()
    
    private lazy var googleContainerView: ContanierView = {
        let googleContainerView = ContanierView(image: "google", title: "Sign in with Google", configForScreen: .login)
        googleContainerView.layer.cornerRadius = 24
        googleContainerView.layer.borderColor = UIColor(named: "textBorderColor")?.cgColor
        googleContainerView.layer.borderWidth = 1
        googleContainerView.isUserInteractionEnabled = true

                let tap = UITapGestureRecognizer(target: self, action: #selector(myViewTapped))
        googleContainerView.addGestureRecognizer(tap)
        googleContainerView.translatesAutoresizingMaskIntoConstraints = false
        return googleContainerView
    }()
    
    private lazy var facebookContainerView: ContanierView = {
        let googleContainerView = ContanierView(image: "facebook", title: "Sign in with Apple", configForScreen: .login)
        googleContainerView.layer.cornerRadius = 24
        googleContainerView.layer.borderColor = UIColor(named: "textBorderColor")?.cgColor
        googleContainerView.layer.borderWidth = 1
        googleContainerView.translatesAutoresizingMaskIntoConstraints = false
        return googleContainerView
    }()
    
    private let divider = DividerView(text: "OR")
    
    var callback: (() ->Void)?
    
    private let vm: LoginViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(viewModel: LoginViewModel) {
        vm = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
     required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configConstraint() {
        [emailContainerView, passwordContainerView, signInButton, questionLabel, signUpButton, divider, googleContainerView, appleContainerView, facebookContainerView].forEach { view in
            self.view.addSubview(view)
        }
        [emailImage, emailTextField].forEach { view in
            emailContainerView.addSubview(view)
        }
        [passwordImage, passwordTextField, visibilityButton].forEach { view in
            passwordContainerView.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            emailContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                       constant: 24),
            emailContainerView.leadingAnchor.constraint(equalTo:
                                                            view.leadingAnchor,
                                                           constant: 24),
            emailContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                            constant: -24),
            emailContainerView.heightAnchor.constraint(equalToConstant: 56),
           
            
            emailImage.centerYAnchor.constraint(equalTo: emailContainerView.centerYAnchor),
            emailImage.leadingAnchor.constraint(equalTo: emailContainerView.leadingAnchor, constant: 24),
            emailImage.widthAnchor.constraint(equalToConstant: 24),
            emailImage.heightAnchor.constraint(equalToConstant: 24),
            
            emailTextField.leadingAnchor.constraint(equalTo: emailImage.trailingAnchor, constant: 16),
            emailTextField.topAnchor.constraint(equalTo: emailContainerView.topAnchor),
            emailTextField.bottomAnchor.constraint(equalTo: emailContainerView.bottomAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: emailContainerView.trailingAnchor, constant: -8),
            
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
            
            passwordTextField.leadingAnchor.constraint(equalTo: passwordImage.trailingAnchor, constant: 16),
            passwordTextField.topAnchor.constraint(equalTo: passwordContainerView.topAnchor),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordContainerView.bottomAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: visibilityButton.leadingAnchor, constant: -8),
            
            signInButton.leadingAnchor.constraint(equalTo: passwordContainerView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: passwordContainerView.trailingAnchor),
            signInButton.topAnchor.constraint(equalTo: passwordContainerView.bottomAnchor, constant: 32),
            signInButton.heightAnchor.constraint(equalToConstant: 56),
            
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 69),
            questionLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 24),
            
            signUpButton.leadingAnchor.constraint(equalTo: questionLabel.trailingAnchor, constant: 5),
            signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 24),
            signUpButton.centerYAnchor.constraint(equalTo: questionLabel.centerYAnchor),
            
            divider.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 41),
            divider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            divider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            divider.heightAnchor.constraint(equalToConstant: 20),
            
            googleContainerView.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 28),
            googleContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.87),
            googleContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            googleContainerView.heightAnchor.constraint(equalToConstant: 56),
            
            appleContainerView.topAnchor.constraint(equalTo: googleContainerView.bottomAnchor, constant: 16),
            appleContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.87),
            appleContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appleContainerView.heightAnchor.constraint(equalToConstant: 56),
            
            facebookContainerView.topAnchor.constraint(equalTo: appleContainerView.bottomAnchor, constant: 16),
            facebookContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.87),
            facebookContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            facebookContainerView.heightAnchor.constraint(equalToConstant: 56),
        ])
    }

    override func configUI() {
        self.title = "Login"
        view.backgroundColor = .systemBackground
    }
    
    override func configVM() {
        let coordinator = StatusCoordinator(navigationController: self.navigationController ?? UINavigationController(), configFor: .login)
        vm.completion = { [weak self] viewState in
                switch viewState {
                case .success(let data):
                    self?.vm.saveUser(user: data)
                    coordinator.configFor = Status.login
                    coordinator.start()
                case .error(let error):
                    coordinator.configFor = Status.error(error: error)
                    coordinator.start()
                }
            }
    }
    
    @objc func textFieldEditingChanged(_ sender: UITextField) {
        let enabled = UIColor(named: "buttonStart")
        let disabled = UIColor(named: "placeholderColor")
        
        if sender.text == "" {
            signInButton.isEnabled = false
            signInButton.alpha = 0.6
            switch sender {
            case emailTextField:
                emailImage.tintColor = disabled
            case passwordTextField:
                passwordImage.tintColor = disabled
            default:
                break
            }
        } else {
            switch sender {
            case emailTextField:
                emailImage.tintColor = enabled
            case passwordTextField:
                passwordImage.tintColor = enabled
            default:
                break
            }
            if !(emailTextField.text?.isEmpty ?? true) && !(passwordTextField.text?.isEmpty ?? true) {
                signInButton.isEnabled = true
                signInButton.alpha = 1
            }
        }
    }
    
    @objc func signIn() {
        let email = (emailTextField.text ?? "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        let password = (passwordTextField.text ?? "")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        vm.login(email: email, password: password)
    }
    
    @objc func signUp() {
        let coordinator = RegisterCoordinator(navigationController: self.navigationController ?? UINavigationController())
        coordinator.start()
    }
    
    @objc func changeVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        passwordTextField.isSecureTextEntry ? visibilityButton.setImage(UIImage(systemName: "eye.slash"), for: .normal) : visibilityButton.setImage(UIImage(systemName: "eye"), for: .normal)
    }
    
    @objc private func myViewTapped() {
        // burda istədiyin func çağır
        print("Tapped!")
        vm.loginWithGoogle()
    }

}
