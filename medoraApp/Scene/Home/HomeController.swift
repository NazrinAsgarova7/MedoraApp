//
//  HomeController.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 13.11.25.
//

import UIKit

class HomeController: BaseController {
    private lazy var searchContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "textBackground")
        view.layer.cornerRadius = 24
        view.layer.borderColor = UIColor(named: "textBorderColor")?.cgColor
        view.layer.borderWidth = 1
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var searchTextField: UITextField = {
        let t = UITextField()
        t.placeholder = "Search doctor, drugs, articles..."
        t.addTarget(self, action: #selector(searchTyping), for: .editingChanged)
        t.delegate = self
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
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.sectionInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.showsVerticalScrollIndicator = false
        cv.register(DoctorCell.self, forCellWithReuseIdentifier: "DoctorCell")
        cv.register(InformationCell.self, forCellWithReuseIdentifier: "InformationCell")
        cv.register(
            HeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "\(HeaderView.self)"
        )
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Find your desire\nhealt solution"
        titleLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        titleLabel.set(line: 8)
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    private lazy var bellButton: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(named: "notification"), for: .normal)
        b.tintColor = .black
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let vm: HomeViewModel
    
    init(vm: HomeViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configUI() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc private func searchTyping() {
        let query = searchTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if query.isEmpty {
            vm.getAllDoctors()
        } else {
            vm.search(query: query)
        }
    }
    
    override func configConstraint() {
        [collectionView, searchContainerView, titleLabel, bellButton].forEach { view.addSubview($0) }
        [searchImage, searchTextField].forEach {
            searchContainerView.addSubview($0)
        }
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 72),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            
            bellButton.heightAnchor.constraint(equalToConstant: 24),
            bellButton.widthAnchor.constraint(equalToConstant: 24),
            bellButton.bottomAnchor.constraint(equalTo: searchContainerView.topAnchor, constant: -52),
            bellButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            collectionView.topAnchor.constraint(equalTo: searchContainerView.bottomAnchor, constant: 7),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            searchContainerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            searchContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchContainerView.heightAnchor.constraint(equalToConstant: 56),
            searchContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.87),
            
            searchImage.leadingAnchor.constraint(equalTo: searchContainerView.leadingAnchor, constant: 17),
            searchImage.centerYAnchor.constraint(equalTo: searchContainerView.centerYAnchor),
            searchImage.widthAnchor.constraint(equalToConstant: 18),
            searchImage.heightAnchor.constraint(equalToConstant: 18),
            
            searchTextField.leadingAnchor.constraint(equalTo: searchImage.trailingAnchor, constant: 12),
            searchTextField.trailingAnchor.constraint(equalTo: searchContainerView.trailingAnchor, constant: -10),
            searchTextField.topAnchor.constraint(equalTo: searchContainerView.topAnchor),
            searchTextField.bottomAnchor.constraint(equalTo: searchContainerView.bottomAnchor),
        ])
    }
    
    override func configVM() {
        vm.getAllDoctors()
        vm.getCategories()
        vm.completion = { [weak self] viewState in
            switch viewState {
            case .success:
                self?.collectionView.reloadData()
            case .error(let error):
                print(error)
            }
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1
        case 1:
            return vm.doctors?.count ?? 4
        default:
            return vm.doctors?.count ?? 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(InformationCell.self)", for: indexPath)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(DoctorCell.self)", for: indexPath) as! DoctorCell
            cell.config(doctor: vm.doctors?[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "HeaderView",
            for: indexPath
        ) as! HeaderView
        header.callback = { [weak self] id, index in
            self?.vm.getDoctorByCategoryId(id: id, index: index)
        }
        header.configHeader(categories: vm.categories,
                            selectedId: vm.selectedCategoryId)
        header.isHidden = indexPath.section == 1
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
            return CGSize(width: 0, height: 20)
        }
        return CGSize(width: collectionView.bounds.width, height: 100)
    }
    
    func collectionView(_ cv: UICollectionView,
                        layout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section{
        case 0:
            return .init(width: view.frame.size.width * 0.89, height: 135)
        case 1:
            return .init(width: 165, height: 241)
            
        default:
            return .init(width: 165, height: 241)
        }
        
    }
}

extension HomeController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {        textField.resignFirstResponder()
        return true
    }
}
