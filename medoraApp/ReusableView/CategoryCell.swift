//
//  CategoryCell.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 21.11.25.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.05
        view.layer.shadowRadius = 8
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.masksToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var image: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "heart")
        img.contentMode = .scaleAspectFit
        img.tintColor = UIColor(named: "buttonStart")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14, weight: .regular)
        l.text = "asas"
        l.textColor = UIColor(named: "descriptionColor")
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override var isSelected: Bool {
            didSet {
                UIView.animate(withDuration: 0.25) {
                    if self.isSelected {
                        self.containerView.backgroundColor = UIColor(named: "buttonStart") ?? .systemBlue
                      //  self.titleLabel.textColor = .white
                        self.image.tintColor = .white
                    } else {
                        self.containerView.backgroundColor = .white
                      //  self.titleLabel.textColor = .label
                        self.image.tintColor = UIColor(named: "buttonStart")
                    }
                }
            }
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configConstraint() {
        [nameLabel, containerView].forEach { contentView.addSubview($0) }
        containerView.addSubview(image)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -8),
            
            image.heightAnchor.constraint(equalToConstant: 32),
            image.widthAnchor.constraint(equalToConstant: 32),
            image.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 8),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
    }
    
    func configUI(category: Category?){
        image.image = UIImage(systemName: category?.icon ?? "")
        nameLabel.text = category?.name
    }
}
