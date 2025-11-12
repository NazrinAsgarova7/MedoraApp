//
//  BottomSheetCell.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 12.11.25.
//

import UIKit

struct BottomSheetCellModel: BottomSheetCellProtocol {
    var title: String
    var description: String
    var firstButtonTitle: String
    var secondButtonTitle: String
}

protocol BottomSheetCellProtocol {
    var title: String { get }
    var description: String { get }
    var firstButtonTitle: String { get }
    var secondButtonTitle: String { get }
}

class BottomSheetCell: UICollectionViewCell {
    
    private var titleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 22, weight: .semibold)
        l.textColor = .black
        l.numberOfLines = 0
        l.textAlignment = .center
        l.set(line: 8)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private var descriptionLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = UIColor(named: "descriptionColor")
        l.numberOfLines = 0
        l.set(line: 10)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var nextButton: UIButton = {
        let button =  GradientButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.gradientColors = [UIColor(named: "buttonStart") ?? .gray,
                                 UIColor(named: "buttonEnd") ?? .gray]
        button.tintColor = .white
        button.startPoint = CGPoint(x: 0, y: 0)
        button.endPoint   = CGPoint(x: 1, y: 1)
        button.corner = 30
        button.addTarget(self, action: #selector(tappedNextButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(UIColor(named: "buttonStart"), for: .normal)
        button.layer.cornerRadius = 28
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3        // neçə səhifən varsa
        pageControl.currentPage = 0          // başlanğıcda 1-ci səhifə
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .systemBlue
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var callbackController: (() -> Void)?
    
    func configConstraint() {
        [titleLabel, descriptionLabel, nextButton, skipButton, pageControl].forEach { element in
            contentView.addSubview(element)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 38),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -38),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            skipButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            skipButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            skipButton.widthAnchor.constraint(equalToConstant: 327),
            skipButton.heightAnchor.constraint(equalToConstant: 56),
            
            nextButton.widthAnchor.constraint(equalToConstant: 327),
            nextButton.heightAnchor.constraint(equalToConstant: 56),
            nextButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: skipButton.topAnchor, constant: -8),
            
           
            pageControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -28),
            pageControl.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 28),
        ])
    }
    
   
    @objc func tappedNextButton() {
     //   dismiss(animated: true)
        callbackController?()
    }
    
    func config(model: BottomSheetCellProtocol, index: Int) {
        pageControl.currentPage = index
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        skipButton.setTitle(model.secondButtonTitle, for: .normal)
        nextButton.setTitle(model.firstButtonTitle, for: .normal)
    }
}


final class GradientButton: UIButton {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    private var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }

    var gradientColors: [UIColor] = [] { didSet { updateGradient() } }
    var startPoint: CGPoint = CGPoint(x: 0, y: 0) { didSet { updateGradient() } }
    var endPoint: CGPoint   = CGPoint(x: 1, y: 1) { didSet { updateGradient() } }
    var corner: CGFloat = 0 { didSet { layer.cornerRadius = corner; layer.masksToBounds = true } }

    private func updateGradient() {
        gradientLayer.colors = gradientColors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
    }
}
