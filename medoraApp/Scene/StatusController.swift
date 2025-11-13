//
//  View.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 11.11.25.
//

import UIKit

enum Status {
    case login, register, error
}

class StatusController: BaseController {
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "viewBackGroundColor")
        view.layer.cornerRadius = 51
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var successImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "checkmark")
        image.tintColor = UIColor(named: "success")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor(named: "descriptionColor")
        label.set(line: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = GradientButton()
        button.gradientColors = [UIColor(named: "buttonStart") ?? .gray,
                                 UIColor(named: "buttonEnd") ?? .gray]
        button.tintColor = .white
        button.startPoint = CGPoint(x: 0, y: 0)
        button.endPoint   = CGPoint(x: 1, y: 1)
        button.corner = 30
        button.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 24
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var dimView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.black.withAlphaComponent(0.45)
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configConstraint() {
        [dimView, cardView].forEach { view.addSubview($0) }
        
        [backgroundView, descriptionLabel, button, titleLabel].forEach { view in
            cardView.addSubview(view)
        }
        backgroundView.addSubview(successImage)
        
        NSLayoutConstraint.activate([
            dimView.topAnchor.constraint(equalTo: view.topAnchor),
            dimView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            cardView.heightAnchor.constraint(equalToConstant: 401),
            cardView.widthAnchor.constraint(equalToConstant: 327),
            cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            backgroundView.heightAnchor.constraint(equalToConstant: 102),
            backgroundView.widthAnchor.constraint(equalToConstant: 102),
            backgroundView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 60),
            backgroundView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            
            successImage.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            successImage.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            successImage.heightAnchor.constraint(equalToConstant: 50),
            successImage.widthAnchor.constraint(equalToConstant: 50),
            
            titleLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 40),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 18.5),
            descriptionLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -18.5),
            
            button.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 56),
            button.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            
        ])
    }
    
    override func configUI() {
        view.backgroundColor = .clear
    }
    
    func configForSuccess(status: Status) {
        switch status {
        case .login:
            titleLabel.text = "Yeay! Welcome Back"
            descriptionLabel.text = "Once again you login successfully into medora app"
            descriptionLabel.set(line: 8)
            button.setTitle("Go to home", for: .normal)
        case .register:
            titleLabel.text = "Success"
            descriptionLabel.text = "Your account has been successfully registered"
            descriptionLabel.set(line: 8)
            button.setTitle("Login", for: .normal)
        case .error:
            break
        }
       
    }

    @objc func tappedButton() {
        switch button.titleLabel?.text {
        case "Login":
            let controller = UINavigationController(rootViewController: LoginController())
            controller.modalPresentationStyle = .fullScreen
            show(controller, sender: nil)
        case "Go to home":
            guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let delegate = scene.delegate as? SceneDelegate else { return }
            delegate.tabbarRoot()
        default:
            dismiss(animated: true)
        }
    }
}
