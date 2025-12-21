//
//  leftIconRightNameCellTableViewCell.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 24.11.25.
//

import UIKit

class LeftIconRightNameCell: UITableViewCell {
    
    private lazy var iconImageView: UIImageView = {
        let icon = UIImageView()
     //   icon.image = UIImage(systemName: "heart")
        icon.tintColor = UIColor(named: "buttonStart")
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Help & Support"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var iconContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "informationViewBg")
        view.layer.cornerRadius = 21.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configConstraint() {
        [nameLabel, iconContainerView].forEach { contentView.addSubview($0) }
        iconContainerView.addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            iconContainerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            iconContainerView.heightAnchor.constraint(equalToConstant: 43),
            iconContainerView.widthAnchor.constraint(equalToConstant: 43),
            
            iconImageView.centerYAnchor.constraint(equalTo:iconContainerView.centerYAnchor),
            iconImageView.centerXAnchor.constraint(equalTo: iconContainerView.centerXAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 18)
        ])
    }
    
    func configScreen(icon: (String, String)) {
        iconImageView.image = UIImage(systemName: icon.0)
        nameLabel.text = icon.1
        if icon.1 == "Logout" {
            iconImageView.tintColor = UIColor(named: "error")
            nameLabel.textColor = UIColor(named: "error")
        }
    }
    
    func configForHelp(icon: (String, String)) {
        iconImageView.image = UIImage(systemName: icon.0)
        nameLabel.text = icon.1
    }
    
    func configforAppointment(appointment: Appointment?) {
       // iconImageView.loadImage(image: doctor?.photoURL ?? "")
        iconImageView.image = UIImage(systemName: "text.document")
        nameLabel.text = (appointment?.date?.changeFormatddMMyyyy() ?? "") + " - " + (appointment?.doctor?.name ?? "")
    }
}

