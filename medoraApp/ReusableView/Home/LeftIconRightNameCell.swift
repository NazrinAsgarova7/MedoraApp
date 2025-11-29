//
//  leftIconRightNameCellTableViewCell.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 24.11.25.
//

import UIKit

class LeftIconRightNameCell: UITableViewCell {

    let icons = [("text.document", "Appointments"),
                 ("shield", "Privacy & Security"),
                 ("questionmark", "Help & Support"),
                 ("rectangle.portrait.and.arrow.right", "Logout")]
    
    let iconsForHelp = [
        ("envelope","medora@gmail.com"),
        ("phone","012-789-98-98")
    ]
    
    private lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "heart")
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
        iconContainerView.addSubview(icon)
        
        NSLayoutConstraint.activate([
            iconContainerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            iconContainerView.heightAnchor.constraint(equalToConstant: 43),
            iconContainerView.widthAnchor.constraint(equalToConstant: 43),
            
            icon.centerYAnchor.constraint(equalTo:iconContainerView.centerYAnchor),
            icon.centerXAnchor.constraint(equalTo: iconContainerView.centerXAnchor),
            icon.heightAnchor.constraint(equalToConstant: 24),
            icon.widthAnchor.constraint(equalToConstant: 24),
            
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 18)
        ])
    }
    
    func configScreen(index: Int) {
        icon.image = UIImage(systemName: icons[index].0)
        nameLabel.text = icons[index].1
        if index == icons.count - 1 {
            icon.tintColor = UIColor(named: "error")
            nameLabel.textColor = UIColor(named: "error")
        }
    }
    
    func configForHelp(index: Int) {
        icon.image = UIImage(systemName: iconsForHelp[index].0)
        nameLabel.text = iconsForHelp[index].1
    }
}
