//
//  SeondSheetController.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 09.11.25.
//

import UIKit

class SeondBottomSheet: BaseController {
    
    private var titleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 22, weight: .semibold)
        l.textColor = .black
        l.numberOfLines = 0
        l.textAlignment = .center
        l.text = "Wellness at Your Fingertips with Doctor+"
        l.set(line: 8)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private var descriptionLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = UIColor(named: "descriptionColor")
        l.numberOfLines = 0
        l.text = "Urna amet, suspendisse ullamcorper ac elit diam facilisis cursus vestibulum."
        l.set(line: 10)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.addTarget(self, action: #selector(tappedNextButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(UIColor(named: "buttonStart"), for: .normal)
        button.layer.cornerRadius = 28
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var callbackController: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let start = UIColor(named: "buttonStart")!
        let end   = UIColor(named: "buttonEnd")!
        nextButton.applyGradient(colors: [start, end],
                                 startPoint: CGPoint(x: 0, y: 0),
                                 endPoint: CGPoint(x: 1, y: 1),
                                 cornerRadius: 30)
    }

    override func configConstraint() {
        [titleLabel, descriptionLabel, nextButton, skipButton].forEach { element in
            view.addSubview(element)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -38),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            skipButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            skipButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            skipButton.widthAnchor.constraint(equalToConstant: 327),
            skipButton.heightAnchor.constraint(equalToConstant: 56),
            
            nextButton.widthAnchor.constraint(equalToConstant: 327),
            nextButton.heightAnchor.constraint(equalToConstant: 56),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: skipButton.topAnchor, constant: -8),
        ])
    }
    
    @objc func tappedNextButton() {
        dismiss(animated: true)
        callbackController?()
    }

}
