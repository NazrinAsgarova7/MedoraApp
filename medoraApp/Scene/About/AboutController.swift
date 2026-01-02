//
//  AboutController.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 26.12.25.
//

import UIKit

class AboutController: BaseController {
    
    private lazy var tableView: UITableView = {
        let t = UITableView(frame: .zero, style: .insetGrouped)
        t.delegate = self
        t.dataSource = self
        t.backgroundColor = .systemGroupedBackground
        t.rowHeight = UITableView.automaticDimension
        t.estimatedRowHeight = 56
        t.separatorInset = UIEdgeInsets(top: 0, left: 56, bottom: 0, right: 16)
        t.register(AboutHeaderView.self, forHeaderFooterViewReuseIdentifier: "AboutHeaderView")
        t.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private enum Section: Int, CaseIterable {
        case mission
        case features
    }
    
    private var sections: [Section] = [.mission, .features]
   
    
    var vm: AboutViewModel
    
    init(vm: AboutViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configUI() {
        view.backgroundColor = .systemBackground
        self.title = "Medora Hospital"
    }
    
    override func configConstraint() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func configVM() {
        vm.completion = { [weak self] viewState in
            switch viewState {
            case .success:
                self?.tableView.reloadData()
            case .error(error: let err):
                print(err)
            }
        }
        Task {
            await vm.getAboutScreen()
        }
    }
}


extension AboutController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .mission: return 1
        case .features: return vm.info?.why?.items?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch sections[section] {
        case .mission: return vm.info?.mission?.title
        case .features: return vm.info?.why?.title
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.textProperties.numberOfLines = 0
        content.secondaryTextProperties.numberOfLines = 0
        
        switch sections[indexPath.section] {
        case .mission:
            content.text = vm.info?.mission?.text
            content.textProperties.font = .systemFont(ofSize: 15)
            content.textProperties.color = .secondaryLabel
            content.image = nil
            content.secondaryText = nil
            cell.selectionStyle = .none
            
        case .features:
            let item = vm.info?.why?.items?[indexPath.row]
            content.text = item?.title
            content.secondaryText = item?.subtitle
            content.image = UIImage(systemName: item?.icon ?? "")
            content.imageProperties.tintColor = .buttonStart
            cell.selectionStyle = .none
        }
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch sections[section] {
        case .mission:
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "AboutHeaderView") as! AboutHeaderView
            view.configure(appName: vm.info?.hero?.title ?? "", subtitle: vm.info?.hero?.subtitle ?? "", icon: vm.info?.hero?.leftIcon ?? "", imageUrl: vm.info?.hero?.imageURL ?? "")
            return view
        case .features: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch sections[section] {
        case .mission: return 200
        case .features: return 20
        }
    }
}
