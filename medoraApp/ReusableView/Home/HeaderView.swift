//
//  HeaderView.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 16.11.25.
//
import UIKit

class HeaderView: UICollectionReusableView {
    enum Function {
        case getAllDoctor
        case getDoctorByCategoryId(id: String, index: Int)
        case search(query: String)
    }
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 2
        l.font = .systemFont(ofSize: 22, weight: .semibold)
        l.text = "Find your desire\nhealth solution"
        l.set(line: 8)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var bellButton: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(named: "notification"), for: .normal)
        b.tintColor = .black
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    private lazy var searchContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "textBackground")
        view.layer.cornerRadius = 24
        view.layer.borderColor = UIColor(named: "textBorderColor")?.cgColor
        view.layer.borderWidth = 1
        let tap = UITapGestureRecognizer(target: self, action: #selector(searchTapped))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var searchTextField: UITextField = {
        let t = UITextField()
        t.placeholder = "Search doctor, drugs, articles..."
        //t.returnKeyType = .search
        t.delegate = self
        t.addTarget(self, action: #selector(searchTyping), for: .editingChanged)
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private lazy var searchImage: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "search")
        i.contentMode = .scaleAspectFill
        i.tintColor = UIColor(named: "placeholderColor")
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.allowsMultipleSelection = false
        cv.showsHorizontalScrollIndicator = false
        cv.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
  //  private var vm: HomeViewModel?
    private  var categories: [Category]?
    var callback: ((Function) -> Void)?
    
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
//        searchTextField.delegate = self
//        searchTextField
        configConstraint()
    }
    
    private func configConstraint() {
        [titleLabel, bellButton, searchContainerView, collectionView].forEach {
            self.addSubview($0)
        }
        [searchImage, searchTextField].forEach {
            searchContainerView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            
            bellButton.heightAnchor.constraint(equalToConstant: 24),
            bellButton.widthAnchor.constraint(equalToConstant: 24),
            bellButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            bellButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            searchContainerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            searchContainerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            searchContainerView.heightAnchor.constraint(equalToConstant: 56),
            searchContainerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.87),
            
            searchImage.leadingAnchor.constraint(equalTo: searchContainerView.leadingAnchor, constant: 17),
            searchImage.centerYAnchor.constraint(equalTo: searchContainerView.centerYAnchor),
            searchImage.widthAnchor.constraint(equalToConstant: 18),
            searchImage.heightAnchor.constraint(equalToConstant: 18),
            
            searchTextField.centerYAnchor.constraint(equalTo: searchContainerView.centerYAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: searchImage.trailingAnchor, constant: 12),
            searchTextField.trailingAnchor.constraint(equalTo: searchContainerView.trailingAnchor, constant: -10),
            
            collectionView.topAnchor.constraint(equalTo: searchContainerView.bottomAnchor, constant: 7),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            collectionView.leadingAnchor.constraint(equalTo: searchContainerView.leadingAnchor, constant: 4),
            collectionView.trailingAnchor.constraint(equalTo: searchContainerView.trailingAnchor, constant: -4),
        ])
        
//        searchTextField.backgroundColor = .red
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
    
    @objc private func searchTapped() {
        searchTextField.becomeFirstResponder()
    }
    
    @objc private func searchTyping() {
        let query = searchTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if query.isEmpty {
            callback?(.getAllDoctor)
        } else {
            callback?(.search(query: query))
        }
    }
}

extension HeaderView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if categories?.count == 0 {
            return 4
        } else {
            return categories?.count ?? 4
        }
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
        callback?(.getDoctorByCategoryId(id: categories?[indexPath.row].id ?? "", index: indexPath.row))
      //  vm?.getDoctorByCategoryId(id: vm?.categories[indexPath.row].id ?? "", index: indexPath.row)
        
    }
}

extension HeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        let query = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
//        if query.isEmpty {
//            callback?(.getAllDoctor)
//          //  vm?.getAllDoctors()
//        } else {
//            callback?(.search(query: query))
//        //    vm?.search(query: query)
//        }
//        print(query)
////        searchTextField.text = ""
////        searchTextField.text = query
        textField.resignFirstResponder()
        return true
    }

}
