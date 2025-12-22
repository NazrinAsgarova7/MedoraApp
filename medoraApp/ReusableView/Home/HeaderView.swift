//
//  HeaderView.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 16.11.25.
//
import UIKit

class HeaderView: UICollectionReusableView {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.sectionInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.allowsMultipleSelection = false
        cv.showsHorizontalScrollIndicator = false
        cv.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private var categories: [Category]?
    var callback: ((String, Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        backgroundColor = .clear
        configConstraint()
    }
    
    private func configConstraint() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
        ])
    }
    
    func configHeader(categories: [Category]?, selectedId: Int) {
        self.categories = categories
        self.collectionView.reloadData()
        let selectedIndex = selectedId
        let indexPath = IndexPath(item: selectedIndex, section: 0)
        if selectedIndex < (categories?.count ?? 0) {
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
        }
    }
}

extension HeaderView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories?.count ?? 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CategoryCell.self)", for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
        if categories?.count == 0 {
            cell.configUI(category: nil)
        } else {
            cell.configUI(category: categories?[indexPath.row])
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 64, height: 84)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        callback?(categories?[indexPath.row].id ?? "", indexPath.row)
    }
}
