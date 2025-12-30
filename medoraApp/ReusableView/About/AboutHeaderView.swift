//
//  AboutHeaderView.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 26.12.25.
//

import Foundation
import UIKit

final class AboutHeaderView: UIView {

    private lazy var card: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemGroupedBackground
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var iconView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tintColor = .white
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var image: UIImageView = {
        let i = UIImageView()
        i.layer.cornerRadius = 16
        i.layer.masksToBounds = true
        i.contentMode = .scaleAspectFill
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func configUI() {
        backgroundColor = .clear
        addSubview(card)
        [ image].forEach { card.addSubview($0) }
        
        [iconView, titleLabel, subtitleLabel].forEach { image.addSubview($0) }

        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            card.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            card.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            card.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            image.leadingAnchor.constraint(equalTo: card.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: card.trailingAnchor),
            image.topAnchor.constraint(equalTo: card.topAnchor),
            image.bottomAnchor.constraint(equalTo: card.bottomAnchor),

            iconView.leadingAnchor.constraint(equalTo: image.leadingAnchor, constant: 16),
            iconView.topAnchor.constraint(equalTo: image.topAnchor, constant: 16),
            iconView.widthAnchor.constraint(equalToConstant: 28),
            iconView.heightAnchor.constraint(equalToConstant: 28),

            titleLabel.leadingAnchor.constraint(equalTo: image.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: image.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 10),

            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            subtitleLabel.bottomAnchor.constraint(equalTo: image.bottomAnchor, constant: -16)
        ])
    }

    func configure(appName: String, subtitle: String, icon: String) {
        titleLabel.text = appName
        subtitleLabel.text = subtitle
        iconView.image = UIImage(systemName: icon)
        image.loadImage(image: "https://i.pinimg.com/1200x/9b/e2/12/9be212df4fc8537ddc31c3f7fa147b42.jpg")
    }
}
