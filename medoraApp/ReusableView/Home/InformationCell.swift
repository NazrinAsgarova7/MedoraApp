//
//  InformationCell.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 22.11.25.
//

import UIKit

class InformationCell: UICollectionViewCell {
    private lazy var informationView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "informationViewBg")
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var informationTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Early protection for\nyour family health"
        label.font = .systemFont(ofSize: 18 ,weight: .semibold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var infoImage: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "infoImage")
        i.contentMode = .scaleAspectFill
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configConstraint() {
        [informationTextLabel, infoImage].forEach {
            informationView.addSubview($0)
        }
        contentView.addSubview(informationView)
        
        NSLayoutConstraint.activate([
            informationView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            informationView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            informationView.topAnchor.constraint(equalTo: contentView.topAnchor),
            informationView.heightAnchor.constraint(equalTo: contentView.heightAnchor),

            informationTextLabel.centerYAnchor.constraint(equalTo: informationView.centerYAnchor),
            informationTextLabel.leadingAnchor.constraint(equalTo: informationView.leadingAnchor, constant: 26),

            infoImage.centerYAnchor.constraint(equalTo: informationView.centerYAnchor),
            infoImage.trailingAnchor.constraint(equalTo: informationView.trailingAnchor, constant: -13),
            infoImage.topAnchor.constraint(equalTo: informationView.topAnchor, constant: 5),
            infoImage.bottomAnchor.constraint(equalTo: informationView.bottomAnchor),
        ])
    }
}
