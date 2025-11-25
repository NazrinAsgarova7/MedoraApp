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
    
    private lazy var imageSkeleton = createSkeleton()
    private lazy var labelSkeleton = createSkeleton()
    private lazy var containerSkeleton = createSkeleton()
    
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
        setupSkeletonViews()
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
        guard let category = category else {
            showSkeleton()
            return
        }
        hideSkeleton()
        image.image = UIImage(systemName: category.icon ?? "")
        nameLabel.text = category.name
    }
}


extension CategoryCell{
    private func setupSkeletonViews() {
        containerView.addSubview(containerSkeleton)
        containerSkeleton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerSkeleton.topAnchor.constraint(equalTo: containerView.topAnchor),
            containerSkeleton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            containerSkeleton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            containerSkeleton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        containerSkeleton.layer.cornerRadius = 16
        containerSkeleton.clipsToBounds = true
        
        image.addSubview(imageSkeleton)
        imageSkeleton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageSkeleton.topAnchor.constraint(equalTo: image.topAnchor),
            imageSkeleton.leadingAnchor.constraint(equalTo: image.leadingAnchor),
            imageSkeleton.trailingAnchor.constraint(equalTo: image.trailingAnchor),
            imageSkeleton.bottomAnchor.constraint(equalTo: image.bottomAnchor)
        ])
        imageSkeleton.layer.cornerRadius = 16
        imageSkeleton.clipsToBounds = true
        
        contentView.addSubview(labelSkeleton)
        labelSkeleton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelSkeleton.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor),
            labelSkeleton.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            labelSkeleton.widthAnchor.constraint(equalToConstant: 70),
            labelSkeleton.heightAnchor.constraint(equalToConstant: 16)
        ])
        labelSkeleton.layer.cornerRadius = 6
        labelSkeleton.clipsToBounds = true
        hideSkeleton()
    }
    
    private func createSkeleton() -> ShimmerView {
        let v = ShimmerView()
        v.isHidden = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }
    
    private func showSkeleton() {
        image.isHidden = true
        nameLabel.isHidden = true
        
        imageSkeleton.isHidden = false
        labelSkeleton.isHidden = false
        containerSkeleton.isHidden = false
        
        imageSkeleton.startShimmering()
        labelSkeleton.startShimmering()
        containerSkeleton.startShimmering()
    }
    
    private func hideSkeleton() {
        image.isHidden = false
        nameLabel.isHidden = false
        
        imageSkeleton.stopShimmering()
        labelSkeleton.stopShimmering()
        containerSkeleton.stopShimmering()
        
        imageSkeleton.isHidden = true
        labelSkeleton.isHidden = true
        containerSkeleton.isHidden = true
    }
}
