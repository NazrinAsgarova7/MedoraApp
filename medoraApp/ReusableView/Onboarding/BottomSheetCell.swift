//
//  BottomSheetCell.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 12.11.25.
//

import UIKit

struct BottomSheetCellModel {
    var title: String
    var description: String
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
    
    func config(model: BottomSheetCellModel) {
        titleLabel.text = model.title
        titleLabel.set(line: 8)
        descriptionLabel.text = model.description
        descriptionLabel
            .set(line: 8)

    }
}
