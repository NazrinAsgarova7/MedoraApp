//
//  EmptyView.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 17.12.25.
//
import UIKit
import Foundation

class EmptyView: UIView {
    private lazy var emptyImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var messageLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 20, weight: .regular)
        l.textAlignment = .center
        l.textColor = .gray
        l.numberOfLines = 2
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configConstraint()
    }
    
    func configConstraint() {
        [emptyImage, messageLabel].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            emptyImage.widthAnchor.constraint(equalToConstant: 250),
            emptyImage.heightAnchor.constraint(equalToConstant: 200),
            emptyImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: emptyImage.bottomAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: emptyImage.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: emptyImage.trailingAnchor),
        ])
    }
    
    func configUI(message: String?, img: UIImage) {
        emptyImage.image = img
        messageLabel.text = message
    }

}
