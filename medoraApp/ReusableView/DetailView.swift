//
//  DetailView.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 06.12.25.
//

import Foundation
import UIKit

class DetailView: UIView {
    private lazy var imageView: UIImageView = {
        let img = UIImageView()
        img.layer.borderWidth = 1
        img.contentMode = .scaleAspectFill
        img.layer.borderColor = .init(gray: 1, alpha: 1)
        img.layer.cornerRadius = 40
        img.layer.masksToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16, weight: .semibold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var spelizationeLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14, weight: .medium)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var ratingView: ContanierView = {
        let view = ContanierView(image: "", title: "", configForScreen: .doctorDetail)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configConstraint()
    }
    
    func configConstraint() {
        [imageView, nameLabel, spelizationeLabel, ratingView].forEach {
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 12),
            
            spelizationeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            spelizationeLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            spelizationeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            
            ratingView.leadingAnchor.constraint(equalTo: spelizationeLabel.leadingAnchor),
            ratingView.heightAnchor.constraint(equalToConstant: 20),
            ratingView.widthAnchor.constraint(equalToConstant: 30),
            ratingView.topAnchor.constraint(equalTo: spelizationeLabel.bottomAnchor, constant: 6),
        ])
    }

    func configUI(doctor: Doctor?) {
        imageView.loadImage(image: doctor?.photoURL ?? "")
        nameLabel.text = doctor?.name
        spelizationeLabel.text = doctor?.specialization
        ratingView.configUI(image: "Star", title: String(doctor?.ratingAverage ?? 0))
    }
}
