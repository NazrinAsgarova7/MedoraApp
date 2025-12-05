//
//  ContanierTextField.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 05.12.25.
//

import Foundation
import UIKit

class ContanierTextField: UIView {
    
//    private lazy var textFieldContainerView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor(named: "textBackground")
//        view.layer.cornerRadius = 24
//        view.layer.borderColor = UIColor(named: "textBorderColor")?.cgColor
//        view.layer.borderWidth = 1
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
    private lazy var textField: UITextField = {
        let t = UITextField()
        t.placeholder = "Enter your name"
      //  t.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
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
    
    init() {
        super.init(frame: .zero)
        configConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI(image: String, placeholder: String?) {
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
        ])
     
    }
}
