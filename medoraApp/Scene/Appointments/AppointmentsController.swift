//
//  AppointmentsController.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 19.12.25.
//

import UIKit

class AppointmentsController: BaseController {
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(LeftIconRightNameCell.self, forCellReuseIdentifier: "LeftIconRightNameCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private var vm: AppointmentsViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    init(vm: AppointmentsViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configConstraint() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    override func configVM() {
        Task {
            await vm.getUserAppointments()
        }
        
        vm.completion = { [weak self] viewState in
            switch viewState {
            case .success:
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .error(error: let error):
                print(error)
            }
        }
    }
    
    override func configUI() {
        self.title = "Appointments"
    }
}

extension AppointmentsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        vm.appointments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LeftIconRightNameCell") as? LeftIconRightNameCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        Task {
            await vm.getDoctorById(doctorId: vm.appointments?[indexPath.row].doctorID ?? "")
        }
        cell.configforAppointment(doctor: vm.doctor, appointment: vm.appointments?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}
