//
//  ContanierTextField.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 05.12.25.
//

import Foundation
import UIKit


enum KeyboardType {
    case text, digital
}

class ContanierTextField: UIView {
    
    private lazy var textField: UITextField = {
        let t = UITextField()
        t.placeholder = "Enter your name"
        t.delegate = self
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private lazy var iconImage: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(systemName: "person")
        i.tintColor = UIColor(named: "placeholderColor")
        i.contentMode = .scaleAspectFill
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    var callback: (() -> Void)?
    
    init() {
        super.init(frame: .zero)
        configConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI(image: String, placeholder: String?, keyboardType: KeyboardType = .text) {
        switch keyboardType {
        case .text:
            textField.keyboardType = .default
        case .digital:
            textField.keyboardType = .phonePad
        }
        iconImage.image = UIImage(systemName: image)
        textField.placeholder = placeholder
    }
    
    func configConstraint() {
        [iconImage, textField].forEach{ addSubview($0) }
        NSLayoutConstraint.activate([
            iconImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            iconImage.widthAnchor.constraint(equalToConstant: 24),
            iconImage.heightAnchor.constraint(equalToConstant: 24),
            
            textField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
     
    }
    
    override var canBecomeFirstResponder: Bool {
            return true
        }

        override func becomeFirstResponder() -> Bool {
            return textField.becomeFirstResponder()
        }

        override var isFirstResponder: Bool {
            return textField.isFirstResponder
        }

        override func resignFirstResponder() -> Bool {
            return textField.resignFirstResponder()
        }
    
}

extension ContanierTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        callback?()
        return true
    }
}
