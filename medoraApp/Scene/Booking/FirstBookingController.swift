//
//  BookingController.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 05.12.25.
//

import UIKit

class FirstBookingController: BaseController {

    private lazy var doctorDetailContainerView: UIView = {
        let view = UIView()
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
    
   /* private lazy var fullnameContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "textBackground")
        view.layer.cornerRadius = 24
        view.layer.borderColor = UIColor(named: "textBorderColor")?.cgColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var fullnameTextField: UITextField = {
        let t = UITextField()
        t.placeholder = "Enter your name"
      //  t.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private lazy var fullnameImage: UIImageView = {
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
        //t.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
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
    
    private lazy var phoneContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "textBackground")
        view.layer.cornerRadius = 24
        view.layer.borderColor = UIColor(named: "textBorderColor")?.cgColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var phoneTextField: UITextField = {
        let t = UITextField()
        t.placeholder = "Enter your password"
        t.isSecureTextEntry = true
       // t.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        t.translatesAutoresizingMaskIntoConstraints = false
        
        return t
    }()
    
    private lazy var phoneImage: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(systemName: "phone")
        i.contentMode = .scaleAspectFill
        i.tintColor = UIColor(named: "placeholderColor")
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }() */
    
    private lazy var personalBioLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16, weight: .medium)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configConstraint() {
        [doctorDetailContainerView, fullnameTextFieldView, personalBioLabel].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            doctorDetailContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.914),
            doctorDetailContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.128),
            doctorDetailContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            doctorDetailContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 78),
            
            personalBioLabel.topAnchor.constraint(equalTo: doctorDetailContainerView.bottomAnchor, constant: 32),
            personalBioLabel.leadingAnchor.constraint(equalTo: doctorDetailContainerView.leadingAnchor),
            personalBioLabel.trailingAnchor.constraint(equalTo: doctorDetailContainerView.trailingAnchor),
            
            fullnameTextFieldView.topAnchor.constraint(equalTo: personalBioLabel.bottomAnchor,  constant: 24),
            fullnameTextFieldView.leadingAnchor.constraint(equalTo: doctorDetailContainerView.leadingAnchor),
            fullnameTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            fullnameTextFieldView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    override func configUI() {
        fullnameTextFieldView.configUI(image: "person.fill", placeholder: "Please enter fullname")
        
    }
}
