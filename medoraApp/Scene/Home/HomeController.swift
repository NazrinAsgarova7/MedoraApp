//
//  HomeController.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 13.11.25.
//

import UIKit

class HomeController: BaseController {

    private lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 2
        l.font = .systemFont(ofSize: 22, weight: .semibold)
        l.text = "Find your desire\nhealt solution"
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
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var searchTextField: UITextField = {
        let t = UITextField()
        t.placeholder = "Search doctor, drugs, articles..."
        t.keyboardType = .emailAddress
//        t.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
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
    
    private lazy var informationView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "informationViewBg")
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var informationTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Early protection for\nyour family health"
        label.font = .systemFont(ofSize: 18 ,weight: .semibold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var infoImage: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "infoImage")
        i.contentMode = .scaleAspectFill
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configUI() {
        navigationController?.setNavigationBarHidden(true, animated: false)

        let titleLabel = UILabel()
        titleLabel.text = "Find your desire\nhealt solution"
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.numberOfLines = 2
    }
    
    override func configConstraint() {
        [titleLabel, bellButton].forEach { headerView.addSubview($0) }
        
        [searchContainerView, headerView, informationView].forEach { view.addSubview($0) }
        
        [searchImage, searchTextField].forEach { searchContainerView.addSubview($0) }
        
        [informationTextLabel, infoImage].forEach { informationView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 64),
            
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 24),
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
            
            bellButton.heightAnchor.constraint(equalToConstant: 24),
            bellButton.widthAnchor.constraint(equalToConstant: 24),
            bellButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            bellButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            
            searchContainerView.topAnchor.constraint(equalTo: headerView.bottomAnchor,
                                                       constant: 20),
            searchContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchContainerView.heightAnchor.constraint(equalToConstant: 56),
            searchContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.87),
            
            searchImage.leadingAnchor.constraint(equalTo: searchContainerView.leadingAnchor, constant: 17),
            searchImage.centerYAnchor.constraint(equalTo: searchContainerView.centerYAnchor),
            searchImage.widthAnchor.constraint(equalToConstant: 18),
            searchImage.widthAnchor.constraint(equalToConstant: 18),
            
            searchTextField.centerYAnchor.constraint(equalTo: searchContainerView.centerYAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: searchImage.trailingAnchor, constant: 12),
            searchTextField.trailingAnchor.constraint(equalTo: searchContainerView.trailingAnchor, constant: -10),
            
            informationView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.166),
            informationView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.893),
            informationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            informationView.topAnchor.constraint(equalTo: searchContainerView.bottomAnchor, constant: 111),
            
            informationTextLabel.centerYAnchor.constraint(equalTo: informationView.centerYAnchor),
            informationTextLabel.leadingAnchor.constraint(equalTo: informationView.leadingAnchor, constant: 26),
            
            infoImage.centerYAnchor.constraint(equalTo: informationView.centerYAnchor),
            infoImage.bottomAnchor.constraint(equalTo: informationView.bottomAnchor),
            infoImage.topAnchor.constraint(equalTo: informationView.topAnchor, constant: 5),
            infoImage.trailingAnchor.constraint(equalTo: informationView.trailingAnchor, constant: -13),
        ])
    }
}
