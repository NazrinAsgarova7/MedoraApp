//
//  HelpBottomSHeet.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 27.11.25.
//

import UIKit

class HelpBottomSheet: BaseController {
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(LeftIconRightNameCell.self, forCellReuseIdentifier: "LeftIconRightNameCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let vm: ProfileViewModel
    
    init(vm: ProfileViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configConstraint() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor,constant: 30),
        ])
    }
}

extension HelpBottomSheet: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LeftIconRightNameCell") as? LeftIconRightNameCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.configForHelp(icon: vm.iconsForHelp[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        69
    }
}
