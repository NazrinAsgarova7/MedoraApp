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
        img.tintColor = .systemBlue
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 2
        return label
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func configUI() {
        backgroundColor = .clear
        addSubview(card)
        [iconView, titleLabel, subtitleLabel].forEach { card.addSubview($0) }

        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            card.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            card.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            card.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),

            iconView.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            iconView.topAnchor.constraint(equalTo: card.topAnchor, constant: 16),
            iconView.widthAnchor.constraint(equalToConstant: 28),
            iconView.heightAnchor.constraint(equalToConstant: 28),

            titleLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 10),

            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            subtitleLabel.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -16)
        ])
    }

    func configure(appName: String, subtitle: String, icon: String) {
        titleLabel.text = appName
        subtitleLabel.text = subtitle
        iconView.image = UIImage(systemName: icon)
    }
}
