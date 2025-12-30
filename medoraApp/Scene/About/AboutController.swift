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
        t.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private enum Section: Int, CaseIterable {
        case mission
        case features
    }
    
    private let heroHeader = AboutHeaderView()
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

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateTableHeaderHeight()
    }
    
    override func configUI() {
        tableView.tableHeaderView = heroHeader
        view.backgroundColor = .systemBackground
        self.title = "Medora Hospital"
        self.heroHeader.configure(appName:  "Medora",
                                  subtitle:  "Healthcare, Simplified.",
                                  icon:  "waveform.path.ecg")
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
                self?.heroHeader.configure(appName:  self?.vm.info?.hero?.title ?? "",
                                           subtitle:  self?.vm.info?.hero?.subtitle ?? "",
                                           icon:  self?.vm.info?.hero?.leftIcon ?? "")

            case .error(error: let err):
                print(err)
            }
        }
        Task {
            await vm.getAboutScreen()
        }
    }

    private func updateTableHeaderHeight() {
        guard let header = tableView.tableHeaderView else { return }

        header.frame.size.width = tableView.bounds.width

        header.setNeedsLayout()
        header.layoutIfNeeded()

        let targetSize = CGSize(width: tableView.bounds.width, height: 0)
        let size = header.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )

        if header.frame.height != size.height {
            header.frame.size.height = size.height
            tableView.tableHeaderView = header
        }
    }
    
}


extension AboutController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section)! {
        case .mission: return 1
        case .features: return vm.info?.why?.items?.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch Section(rawValue: section)! {
        case .mission: return vm.info?.mission?.title
        case .features: return vm.info?.why?.title
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        var content = cell.defaultContentConfiguration()
        content.textProperties.numberOfLines = 0
        content.secondaryTextProperties.numberOfLines = 0
        
        switch section {
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
    
    
}
