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
}

protocol BottomSheetCellProtocol {
    var title: String { get }
    var description: String { get }
}

class BottomSheetCell: UICollectionViewCell {
    
    private var titleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 22, weight: .semibold)
        l.textColor = .black
        l.textAlignment = .center
        l.set(line: 8)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private var descriptionLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = UIColor(named: "descriptionColor")
        l.set(line: 10)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
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
        [titleLabel, descriptionLabel].forEach { element in
            contentView.addSubview(element)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 38),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -38),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
        ])
    }
    
   
    
    func config(model: BottomSheetCellProtocol) {
        titleLabel.text = model.title
        titleLabel.set(line: 8)
        descriptionLabel.text = model.description
        descriptionLabel
            .set(line: 8)

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
