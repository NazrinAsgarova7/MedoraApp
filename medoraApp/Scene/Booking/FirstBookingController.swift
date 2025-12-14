//
//  BookingController.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 05.12.25.
//

import UIKit

class FirstBookingController: BaseController {
    
    private lazy var doctorDetailContainerView: DetailView = {
        let view = DetailView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.05
        view.layer.shadowRadius = 8
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.masksToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var fullnameTextFieldView: ContanierTextField = {
        let fullnameView = ContanierTextField()
        fullnameView.backgroundColor = UIColor(named: "textBackground")
        fullnameView.layer.cornerRadius = 24
        fullnameView.layer.borderColor = UIColor(named: "textBorderColor")?.cgColor
        fullnameView.layer.borderWidth = 1
        fullnameView.translatesAutoresizingMaskIntoConstraints = false
        return fullnameView
    }()
    
    private lazy var emailTextFieldView: ContanierTextField = {
        let emailView = ContanierTextField()
        emailView.backgroundColor = UIColor(named: "textBackground")
        emailView.layer.cornerRadius = 24
        emailView.layer.borderColor = UIColor(named: "textBorderColor")?.cgColor
        emailView.layer.borderWidth = 1
        emailView.translatesAutoresizingMaskIntoConstraints = false
        return emailView
    }()
    
    private lazy var phoneTextFieldView: ContanierTextField = {
        let phoneView = ContanierTextField()
        phoneView.backgroundColor = UIColor(named: "textBackground")
        phoneView.layer.cornerRadius = 24
        phoneView.layer.borderColor = UIColor(named: "textBorderColor")?.cgColor
        phoneView.layer.borderWidth = 1
        phoneView.translatesAutoresizingMaskIntoConstraints = false
        return phoneView
    }()
    
    private lazy var personalBioLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16, weight: .medium)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var continueButton: UIButton = {
        let button = GradientButton()
        button.setTitle("Continue", for: .normal)
        button.gradientColors = [UIColor(named: "buttonStart") ?? .gray,
                                 UIColor(named: "buttonEnd") ?? .gray]
        button.tintColor = .white
        button.startPoint = CGPoint(x: 0, y: 0)
        button.endPoint = CGPoint(x: 1, y: 1)
        button.corner = 30
        button.addTarget(self, action: #selector(tappedContinueButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let viewModel: BookingViewModel
    
    init(viewModel: BookingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configConstraint() {
        [doctorDetailContainerView, fullnameTextFieldView, phoneTextFieldView, emailTextFieldView, personalBioLabel, continueButton].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            doctorDetailContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.914),
            doctorDetailContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.128),
            doctorDetailContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            doctorDetailContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            
            personalBioLabel.topAnchor.constraint(equalTo: doctorDetailContainerView.bottomAnchor, constant: 32),
            personalBioLabel.leadingAnchor.constraint(equalTo: doctorDetailContainerView.leadingAnchor),
            personalBioLabel.trailingAnchor.constraint(equalTo: doctorDetailContainerView.trailingAnchor),
            
            fullnameTextFieldView.topAnchor.constraint(equalTo: personalBioLabel.bottomAnchor,  constant: 24),
            fullnameTextFieldView.leadingAnchor.constraint(equalTo: doctorDetailContainerView.leadingAnchor),
            fullnameTextFieldView.trailingAnchor.constraint(equalTo: doctorDetailContainerView.trailingAnchor),
            fullnameTextFieldView.heightAnchor.constraint(equalToConstant: 60),
            
            emailTextFieldView.topAnchor.constraint(equalTo: fullnameTextFieldView.bottomAnchor, constant: 24),
            emailTextFieldView.leadingAnchor.constraint(equalTo: fullnameTextFieldView.leadingAnchor),
            emailTextFieldView.trailingAnchor.constraint(equalTo: fullnameTextFieldView.trailingAnchor),
            emailTextFieldView.heightAnchor.constraint(equalToConstant: 60),
            
            phoneTextFieldView.topAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: 24),
            phoneTextFieldView.leadingAnchor.constraint(equalTo: fullnameTextFieldView.leadingAnchor),
            phoneTextFieldView.trailingAnchor.constraint(equalTo: fullnameTextFieldView.trailingAnchor),
            phoneTextFieldView.heightAnchor.constraint(equalToConstant: 60),
            
            continueButton.heightAnchor.constraint(equalToConstant: 56),
            continueButton.topAnchor.constraint(equalTo: phoneTextFieldView.bottomAnchor, constant: 32),
            continueButton.leadingAnchor.constraint(equalTo: phoneTextFieldView.leadingAnchor),
            continueButton.trailingAnchor.constraint(equalTo: phoneTextFieldView.trailingAnchor)
            
            
        ])
    }
    
    override func configUI() {
        navigationController?.config()

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        self.title = "Doctor Booking"
        personalBioLabel.text = "Personal Bio"
        fullnameTextFieldView.configUI(image: "person.fill", placeholder: "Enter fullname")
        emailTextFieldView.configUI(image: "envelope.fill", placeholder: "Enter email")
        phoneTextFieldView.configUI(image: "phone.fill", placeholder: "Enter phone", keyboardType: .digital)
        
        fullnameTextFieldView.callback = { [weak self] in
            self?.emailTextFieldView.becomeFirstResponder()
        }
        emailTextFieldView.callback = { [weak self] in
            self?.phoneTextFieldView.becomeFirstResponder()
            
        }
        phoneTextFieldView.callback = { [weak self] in
            self?.view.endEditing(true)
        }
        doctorDetailContainerView.configUI(doctor: viewModel.doctor)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func tappedContinueButton() {
//        let coordinator = BookingCoordinator(navigationController: self.navigationController ?? UINavigationController(), builder: BookingBuilder(), controller: <#UIViewController#>)
//        coordinator.start()
        
        let controller = SecondBookingController(viewModel: viewModel, builder: BookingBuilder())
        show(controller, sender: nil)
    }
}
