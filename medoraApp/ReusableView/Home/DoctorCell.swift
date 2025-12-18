//
//  DoctorCell.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 16.11.25.
//

import UIKit

class DoctorCell: UICollectionViewCell {
    private let containerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "textBorderColor")?.cgColor
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.textColor = .black
        l.text = "Dr. Marcus Horizon"
        l.numberOfLines = 0
        l.font = .systemFont(ofSize: 12, weight: .semibold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var imageView: UIImageView = {
        let i = UIImageView()
        i.contentMode = .scaleAspectFill
        i.image = UIImage(systemName: "person.circle")
        i.tintColor = UIColor.gray
        i.layer.masksToBounds = true
      //  i.layer.cornerRadius = 50
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var specializationLabel: UILabel = {
        let l = UILabel()
        l.textColor = UIColor(named: "descriptionColor")
        l.text = "Chardiologist"
        l.numberOfLines = 0
        l.font = .systemFont(ofSize: 12, weight: .semibold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let ratingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "informationViewBg")
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var starImageView: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(systemName: "star.fill")
        i.tintColor = UIColor(named: "buttonStart")
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var ratingLabel: UILabel = {
        let l = UILabel()
        l.textColor = UIColor(named: "buttonStart")
        l.text = "4.7"
        l.numberOfLines = 0
        l.font = .systemFont(ofSize: 8, weight: .medium)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configConstraint()
        setupSkeletonViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.bounds.height / 2
        imageView.layer.masksToBounds = true
    }
    
    private lazy var containerSkeleton = createSkeleton()
    
    private func configConstraint() {
        [containerView ].forEach { view in
            addSubview(view)
        }
        
        [nameLabel, ratingView, imageView, specializationLabel].forEach { containerView.addSubview($0) }
        
        [starImageView, ratingLabel].forEach { ratingView.addSubview($0) }
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.606),
            imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.414),
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 28),
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            specializationLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            specializationLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            specializationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            ratingView.heightAnchor.constraint(equalToConstant: 18),
            ratingView.widthAnchor.constraint(equalToConstant: 38),
            ratingView.topAnchor.constraint(equalTo: specializationLabel.bottomAnchor, constant: 14),
            ratingView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 14),
            
            starImageView.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor),
            starImageView.leadingAnchor.constraint(equalTo: ratingView.leadingAnchor, constant: 3),
            starImageView.heightAnchor.constraint(equalToConstant: 11),
            starImageView.widthAnchor.constraint(equalToConstant: 11),
            
            ratingLabel.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor),
            ratingLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 3),
        ])
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.05
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.masksToBounds = false
    }
    
    func config(doctor: Doctor?){
        if doctor == nil {
            showSkeleton()
        } else {
            hideSkeleton()
            nameLabel.text = doctor?.name
            specializationLabel.text = doctor?.specialization
            ratingLabel.text = String(doctor?.ratingAverage ?? 0)
            imageView.layer.cornerRadius = imageView.frame.height / 2
            if let img = doctor?.photoURL {
                imageView.loadImage(image: img)
            } else {
                imageView.image = UIImage(systemName: "person.circle")
            }
        }
    }
}

extension DoctorCell{
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
        hideSkeleton()
    }
    
    private func createSkeleton() -> ShimmerView {
        let v = ShimmerView()
        v.isHidden = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }
    
    private func showSkeleton() {
        containerSkeleton.isHidden = false
        containerSkeleton.startShimmering()
    }
    
    private func hideSkeleton() {
        containerSkeleton.stopShimmering()
        containerSkeleton.isHidden = true
        nameLabel.isHidden = false
        specializationLabel.isHidden = false
        ratingView.isHidden = false
        imageView.isHidden = false
    }
}
