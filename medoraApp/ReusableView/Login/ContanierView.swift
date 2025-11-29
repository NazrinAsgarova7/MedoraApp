//
//  ContanierView.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 13.11.25.
//

import UIKit

class ContanierView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16, weight: .semibold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var iconImage: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(systemName: "person")
        i.tintColor = UIColor(named: "placeholderColor")
        i.contentMode = .scaleAspectFill
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    init(image: String, title: String?) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        configConstraint()
        configUI(image: image, title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configConstraint() {
        [titleLabel, iconImage].forEach { self.addSubview($0) }
        
        NSLayoutConstraint.activate([
            
            iconImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            iconImage.widthAnchor.constraint(equalToConstant: 24),
            iconImage.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
          //  titleLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 52),

        ])
    }
    
    func configUI(image: String, title: String?) {
        iconImage.image = UIImage(named: image)
        titleLabel.text = title
    }
}
