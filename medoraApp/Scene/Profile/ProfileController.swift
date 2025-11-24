//
//  ProfileController.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 24.11.25.
//

import UIKit

class ProfileController: BaseController {
    
    private let image: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "profile")
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 30
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(LeftIconRightNameCell.self, forCellReuseIdentifier: "LeftIconRightNameCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "buttonStart")
    }
    
    override func configConstraint() {
        [image, bottomView].forEach { view.addSubview($0) }
        bottomView.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            image.topAnchor.constraint(equalTo: view.topAnchor),
            
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.56),
            
            tableView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: bottomView.topAnchor,constant: 30),
        ])
    }
}

extension ProfileController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LeftIconRightNameCell") as? LeftIconRightNameCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.configScreen(index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        69
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if indexPath.row == 3 {
            let statusVc = StatusController()
            statusVc.modalPresentationStyle = .overFullScreen
            statusVc.modalTransitionStyle = .crossDissolve
            statusVc.configForSuccess(status: .logout)
            self.present(statusVc, animated: true)
        }
    }
}
