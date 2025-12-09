//
//  ContanierView.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 13.11.25.
//

import UIKit

enum ContainerViewConfigFor {
    case doctorDetail, login
}
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
    
    init(image: String, title: String?, configForScreen: ContainerViewConfigFor) {
        self.configForScreen = configForScreen
        super.init(frame: .zero)
        configUI(image: image, title: title)
        configConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var configForScreen: ContainerViewConfigFor
    
    func configConstraint() {
        [titleLabel, iconImage].forEach { self.addSubview($0) }
        
        let iconImageWidth = iconImage.widthAnchor.constraint(equalToConstant: 24)
        let iconImageHeight = iconImage.heightAnchor.constraint(equalToConstant: 24)
        let iconImageLeading = iconImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24)
        let titleLabelCenterX = titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        
        let iconImageWidthForDetail = iconImage.widthAnchor.constraint(equalToConstant: 20)
        let iconImageHeightForDetail = iconImage.heightAnchor.constraint(equalToConstant: 20)
        let iconImageLeadingForDetail = iconImage.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        let titleLabelLeading = titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 26)
        
        switch configForScreen {
        case .doctorDetail:
            iconImageWidthForDetail.isActive = true
            iconImageHeightForDetail.isActive = true
            iconImageLeadingForDetail.isActive = true
            titleLabelLeading.isActive = true
            titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        case .login:
            iconImageWidth.isActive = true
            iconImageHeight.isActive = true
            iconImageLeading.isActive = true
            titleLabelCenterX.isActive = true
        }
        
        NSLayoutConstraint.activate([
            iconImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    func configUI(image: String, title: String?) {
        iconImage.image = UIImage(named: image)
        titleLabel.text = title
    }
}
