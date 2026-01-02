//
//  ProfileController.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 24.11.25.
//

import UIKit
import PhotosUI

class ProfileController: BaseController {
    
    private lazy var image: UIImageView = {
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
    
    private lazy var profileImage: UIImageView = {
        let img = UIImageView(image: UIImage(systemName: "person.circle"))
        img.contentMode = .scaleAspectFill
        img.tintColor = .white
        img.clipsToBounds = true
        img.layer.cornerRadius = 60
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var editButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "pencil"), for: .normal)
        btn.tintColor = .buttonStart
        btn.addTarget(self, action: #selector(selectPhotoTapped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = false
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16, weight: .regular)
        l.textColor = .white
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var emailLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16, weight: .regular)
        l.alpha = 0.8
        l.textColor = .white
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private enum Section: Int, CaseIterable {
        case appointment
        case privacy
        case help
        case logout
    }
    
    private let sections: [Section] = [.appointment, .privacy, .help, .logout]
    private let vm: ProfileViewModel
    
    init(vm: ProfileViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "buttonStart")
    }
    
    override func configConstraint() {
        [image, bottomView, profileImage, backgroundView, nameLabel, emailLabel].forEach { view.addSubview($0) }
        bottomView.addSubview(tableView)
        backgroundView.addSubview(editButton)
        
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
            
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 120),
            profileImage.heightAnchor.constraint(equalToConstant: 120),
            profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            backgroundView.widthAnchor.constraint(equalToConstant: 30),
            backgroundView.heightAnchor.constraint(equalToConstant: 30),
            backgroundView.trailingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: -7),
            backgroundView.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: -7),
            
            editButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            editButton.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            editButton.widthAnchor.constraint(equalToConstant: 22),
            editButton.heightAnchor.constraint(equalToConstant: 22),
            
            
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 16),
            
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
        ])
    }
    
    override func configUI() {
        nameLabel.text = vm.getUserData(key: .name)
        emailLabel.text = vm.getUserData(key: .email)
        loadProfileImage()
    }
    
    @objc func selectPhotoTapped(){
            var config = PHPickerConfiguration()
            config.selectionLimit = 1
            config.filter = .images
            let picker = PHPickerViewController(configuration: config)
            picker.delegate = self
            present(picker, animated: true)
    }
   
    private func loadProfileImage() {
        let url = vm.getProfileImage()
        profileImage.setImage(dataUrl: url)
    }
    
    private func showWebView() {
        navigationController?.config()
       let controller = PrivacyWebViewController()
        show(controller, sender: nil)
    }
}

extension ProfileController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LeftIconRightNameCell") as? LeftIconRightNameCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.configScreen(icon: vm.icons[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        69
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch sections[indexPath.row] {
        case .appointment:
            let coordinator = AppointmentsCoordinator(navigationController: self.navigationController ?? UINavigationController())
            coordinator.start()
        
        case .privacy:
            showWebView()
        case .help:
            let bottomSheetVC = HelpBottomSheet(vm: self.vm)
            bottomSheetVC.modalPresentationStyle = .pageSheet
            bottomSheetVC.isModalInPresentation = false
            if let sheet = bottomSheetVC.sheetPresentationController {
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 40
                let customDetent = UISheetPresentationController.Detent.custom(
                    identifier: .init("seventyPercent")
                ) { context in
                    context.maximumDetentValue * 0.30
                }
                sheet.detents = [customDetent]
                sheet.selectedDetentIdentifier = customDetent.identifier
            }
            present(bottomSheetVC, animated: true)
        case .logout:
            let coordinator = StatusCoordinator(navigationController: self.navigationController ?? UINavigationController(), configFor: .logout)
            coordinator.start()
        }
    }
}

extension ProfileController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)

        guard let provider = results.first?.itemProvider else { return }

        provider.loadDataRepresentation(forTypeIdentifier: "public.image") { [weak self] data, error in
            guard let self, let data else { return }

            DispatchQueue.main.async {
                self.profileImage.image = UIImage(data: data)
            }
            Task{
                await  self.vm.saveProfilePhoto(data: data)
            }
        }
    }
}


