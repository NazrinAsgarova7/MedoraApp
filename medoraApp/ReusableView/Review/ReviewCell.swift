//
//  ReviewCell.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 04.12.25.
//

import UIKit

class ReviewCell: UITableViewCell {
    
    private lazy var containerView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 12
        v.backgroundColor = .systemGray6
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var usernameLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16, weight: .medium)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var ratingView: ContanierView = {
        let contanierView = ContanierView(image: "star.fill", title: "5", configForScreen: .doctorDetail)
        contanierView.translatesAutoresizingMaskIntoConstraints = false
        return contanierView
    }()
    
    private lazy var createdDateLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14, weight: .medium)
        l.textColor = .placeholder
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var reviewLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14, weight: .regular)
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var profileImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "person.fill")
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 24
        img.layer.masksToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var containerSkeleton = createSkeleton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configConstraint() {
        [usernameLabel, ratingView, reviewLabel, profileImage, createdDateLabel].forEach { containerView.addSubview($0) }
        contentView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            profileImage.heightAnchor.constraint(equalToConstant: 48),
            profileImage.widthAnchor.constraint(equalToConstant: 48),
            profileImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            profileImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            
            usernameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 17),
            usernameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 8),
            
            ratingView.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            ratingView.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 4),
            ratingView.heightAnchor.constraint(equalToConstant: 20),
            ratingView.widthAnchor.constraint(equalToConstant: 30),
            
            createdDateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            createdDateLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            
            reviewLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            reviewLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            reviewLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 12),
            
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
    func configUI(review: Review?) {
        guard let review else {
            showSkeleton()
            return
        }
        hideSkeleton()
        usernameLabel.text = review.user?.name
        ratingView.configUI(image: "Star", title: String(review.rating ?? 0))
        createdDateLabel.text = review.createdAt?.timeAgo()
        reviewLabel.text = review.comment
        profileImage.setImage(dataUrl: review.user?.photoURL ?? "")
    }
}

extension ReviewCell {
    private func createSkeleton() -> ShimmerView {
        let v = ShimmerView()
        v.isHidden = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }
    
    private func setupSkeletonViews() {
        [containerSkeleton].forEach { contentView.addSubview($0) }
        
        containerSkeleton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerSkeleton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerSkeleton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerSkeleton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerSkeleton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
        containerSkeleton.layer.cornerRadius = 12

        hideSkeleton()
    }
    
    private func showSkeleton() {
        containerSkeleton.isHidden = false
        profileImage.isHidden = true
        reviewLabel.isHidden = true
        ratingView.isHidden = true
        
        containerSkeleton.startShimmering()
    }
    
    private func hideSkeleton() {
        containerView.isHidden = false
        profileImage.isHidden = false
        reviewLabel.isHidden = false
        ratingView.isHidden = false
        containerSkeleton.stopShimmering()
        
        containerSkeleton.isHidden = true
    }
}
