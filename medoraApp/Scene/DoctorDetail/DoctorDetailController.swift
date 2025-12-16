//
//  DoctorDetail.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 29.11.25.
//

import UIKit

class DoctorDetailController: BaseController {

    private lazy var doctorImage: UIImageView = {
        var img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.image = UIImage(named: "25168-min 1")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var doctorDetailContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.05
        view.layer.shadowRadius = 8
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.masksToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var doctorName: UILabel = {
        var l = UILabel()
        l.font = .systemFont(ofSize: 24, weight: .semibold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var ratingView: ContanierView = {
        let view = ContanierView(image: "Star", title: "4.5", configForScreen: .doctorDetail)
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var locationView: ContanierView = {
        let view = ContanierView(image: "Location", title: "4.5", configForScreen: .doctorDetail)
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var specializationView: ContanierView = {
        let view = ContanierView(image: "", title: "4.5", configForScreen: .doctorDetail)
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var bookContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .informationViewBg
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.05
        view.layer.shadowRadius = 8
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.masksToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var priceLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 24, weight: .bold)
        l.textColor = .buttonStart
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var consultationTitleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14, weight: .medium)
        l.textColor = .buttonStart
        l.text = "Consultation Fee"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var bookButton: UIButton = {
        let b = UIButton()
        b.setTitle("Book ", for: .normal)
        b.setImage(UIImage(systemName: "calendar"), for: .normal)
        b.tintColor = .white
        b.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        b.addTarget(self, action: #selector(tappedBookButton), for: .touchUpInside)
        b.backgroundColor = .buttonStart
        b.layer.cornerRadius = 24
        b.semanticContentAttribute = .forceRightToLeft
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    private lazy var experienceTitleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16, weight: .semibold)
        l.textColor = .black
        l.text = "Medical Experience"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private lazy var yearsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .informationViewBg
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var yearsLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 40, weight: .semibold)
        l.textColor = .buttonStart
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    private lazy var yearsTitleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14, weight: .medium)
        l.text = "Years Exp."
        l.textColor = .buttonStart
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var patientsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .informationViewBg
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var patientsLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 40, weight: .semibold)
        l.textColor = .buttonStart
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    private lazy var patientsTitleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14, weight: .medium)
        l.text = "patients"
        l.textColor = .buttonStart
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var ratingContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .informationViewBg
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var ratingLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 40, weight: .semibold)
        l.textColor = .buttonStart
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    private lazy var ratingTitleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14, weight: .medium)
        l.text = "reviews"
        l.textColor = .buttonStart
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private lazy var seeAllButton: UIButton = {
        let b = UIButton()
        b.setTitle("See All Comments ", for: .normal)
        b.tintColor = .white
        b.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        b.backgroundColor = .buttonStart
        b.layer.cornerRadius = 24
        b.addTarget(self, action: #selector(tappedSeeAllButton), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()

    
    private let vm: DoctorViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(vm: DoctorViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configConstraint() {
        [doctorImage, doctorDetailContainerView, bookContainerView, yearsContainerView, patientsContainerView, experienceTitleLabel, ratingContainerView, seeAllButton].forEach { view.addSubview($0) }
        
        [ratingView, doctorName, locationView, specializationView].forEach { doctorDetailContainerView.addSubview($0) }
        
        [priceLabel, consultationTitleLabel, bookButton].forEach { bookContainerView.addSubview($0) }
        
        yearsContainerView.addSubview(yearsLabel)
        yearsContainerView.addSubview(yearsTitleLabel)
        patientsContainerView.addSubview(patientsLabel)
        patientsContainerView.addSubview(patientsTitleLabel)
        ratingContainerView.addSubview(ratingLabel)
        ratingContainerView.addSubview(ratingTitleLabel)
        
        NSLayoutConstraint.activate([
            doctorImage.topAnchor.constraint(equalTo: view.topAnchor),
            doctorImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            doctorImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            doctorImage.heightAnchor.constraint(equalToConstant: 342),
            
            doctorDetailContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.955),
            doctorDetailContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            doctorDetailContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 309),
            doctorDetailContainerView.heightAnchor.constraint(equalToConstant: 114),
            
            ratingView.topAnchor.constraint(equalTo: doctorName.bottomAnchor, constant: 20),
            ratingView.leadingAnchor.constraint(equalTo: doctorDetailContainerView.leadingAnchor, constant: 34.5),
            ratingView.heightAnchor.constraint(equalToConstant: 22),
            ratingView.widthAnchor.constraint(equalToConstant: 51),
            
            doctorName.centerXAnchor.constraint(equalTo: doctorDetailContainerView.centerXAnchor),
            doctorName.topAnchor.constraint(equalTo: doctorDetailContainerView.topAnchor, constant: 20),
            
            locationView.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor),
            locationView.heightAnchor.constraint(equalToConstant: 22),
            locationView.widthAnchor.constraint(equalToConstant: 74),
            locationView.centerXAnchor.constraint(equalTo: doctorDetailContainerView.centerXAnchor),
            
            specializationView.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor),
            specializationView.trailingAnchor.constraint(equalTo: doctorDetailContainerView.trailingAnchor, constant: -34),
            specializationView.heightAnchor.constraint(equalToConstant: 22),
            specializationView.widthAnchor.constraint(equalToConstant: 112),
            
            bookContainerView.leadingAnchor.constraint(equalTo: doctorDetailContainerView.leadingAnchor),
            bookContainerView.trailingAnchor.constraint(equalTo: doctorDetailContainerView.trailingAnchor),
            bookContainerView.heightAnchor.constraint(equalToConstant: 88),
            bookContainerView.topAnchor.constraint(equalTo: doctorDetailContainerView.bottomAnchor, constant: 24),
            
            bookButton.heightAnchor.constraint(equalToConstant: 48),
            bookButton.widthAnchor.constraint(equalToConstant: 113),
            bookButton.centerYAnchor.constraint(equalTo: bookContainerView.centerYAnchor),
            bookButton.trailingAnchor.constraint(equalTo: bookContainerView.trailingAnchor, constant: -16),
            
            consultationTitleLabel.topAnchor.constraint(equalTo: bookContainerView.topAnchor, constant: 16),
            consultationTitleLabel.leadingAnchor.constraint(equalTo: bookContainerView.leadingAnchor, constant: 16),
            
            priceLabel.topAnchor.constraint(equalTo: consultationTitleLabel.bottomAnchor, constant: 4),
            priceLabel.leadingAnchor.constraint(equalTo: consultationTitleLabel.leadingAnchor),
            
            experienceTitleLabel.topAnchor.constraint(equalTo: bookContainerView.bottomAnchor, constant: 16),
            experienceTitleLabel.leadingAnchor.constraint(equalTo: bookContainerView.leadingAnchor),
            
            yearsContainerView.leadingAnchor.constraint(equalTo: experienceTitleLabel.leadingAnchor),
            yearsContainerView.topAnchor.constraint(equalTo: experienceTitleLabel.bottomAnchor, constant: 12),
            yearsContainerView.heightAnchor.constraint(equalToConstant: 86),
            yearsContainerView.widthAnchor.constraint(equalToConstant: (view.frame.width - 28) / 2),
            
            patientsContainerView.trailingAnchor.constraint(equalTo: bookContainerView.trailingAnchor),
            patientsContainerView.heightAnchor.constraint(equalToConstant: 86),
            patientsContainerView.widthAnchor.constraint(equalToConstant: (view.frame.width - 28) / 2),
            patientsContainerView.topAnchor.constraint(equalTo: experienceTitleLabel.bottomAnchor, constant: 12),
            
            yearsLabel.centerXAnchor.constraint(equalTo: yearsContainerView.centerXAnchor),
            yearsLabel.topAnchor.constraint(equalTo: yearsContainerView.topAnchor, constant: 14),
            
            yearsTitleLabel.centerXAnchor.constraint(equalTo: yearsContainerView.centerXAnchor),
            yearsTitleLabel.topAnchor.constraint(equalTo: yearsLabel.bottomAnchor),
            
            patientsLabel.centerXAnchor.constraint(equalTo: patientsContainerView.centerXAnchor),
            patientsLabel.topAnchor.constraint(equalTo: patientsContainerView.topAnchor, constant: 14),
            
            patientsTitleLabel.centerXAnchor.constraint(equalTo: patientsContainerView.centerXAnchor),
            patientsTitleLabel.topAnchor.constraint(equalTo: patientsLabel.bottomAnchor),
            
            ratingContainerView.trailingAnchor.constraint(equalTo: yearsContainerView.trailingAnchor),
            ratingContainerView.leadingAnchor.constraint(equalTo: bookContainerView.leadingAnchor),
            ratingContainerView.heightAnchor.constraint(equalToConstant: 86),
            ratingContainerView.topAnchor.constraint(equalTo: yearsContainerView.bottomAnchor, constant: 12),
            
            ratingLabel.topAnchor.constraint(equalTo: ratingContainerView.topAnchor, constant: 14),
            ratingLabel.leadingAnchor.constraint(equalTo: yearsLabel.leadingAnchor),
            
            ratingTitleLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor),
            ratingTitleLabel.leadingAnchor.constraint(equalTo: ratingLabel.leadingAnchor),
            
            seeAllButton.centerYAnchor.constraint(equalTo: ratingContainerView.centerYAnchor),
            seeAllButton.heightAnchor.constraint(equalToConstant: 48),
            seeAllButton.leadingAnchor.constraint(equalTo: patientsContainerView.leadingAnchor),
            seeAllButton.trailingAnchor.constraint(equalTo: patientsContainerView.trailingAnchor),
        ])
    }
    
    override func configVM() {
        vm.completion = { [weak self] viewstate in
            switch viewstate {
            case .success:
                self?.configUI()
            case .error(error: let error):
                self?.showAlert(title: "Error",message: error)
            }
        }
        Task {
            await vm.getDoctorDetail()
        }
    }
    
    override func configUI() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.config()
        doctorName.text = vm.doctorDetail?.name
        ratingView.configUI(image: "Star", title: String(vm.doctorDetail?.ratingAverage ?? 0))
        locationView.configUI(image: "Location", title: String(vm.doctorDetail?.distanceM ?? 0) + "m")
        specializationView.configUI(image: "", title: vm.doctorDetail?.specialization)
        priceLabel.text = "$" + String((Double(vm.doctorDetail?.feeCents ?? 0)) / 100)
        patientsLabel.text = String(vm.doctorDetail?.patientsCount ?? 0) + "+"
        yearsLabel.text = String(vm.doctorDetail?.experienceYrs ?? 0 ) + "+"
        ratingLabel.text = String(vm.doctorDetail?.ratingCount ?? 0)
    }
    
    @objc private func tappedSeeAllButton() {
        let coordinator = ReviewCoordinator(navigationController: self.navigationController ?? UINavigationController(), id: vm.id)
        coordinator.start()
    }
    
    @objc private func tappedBookButton() {
        let controller = FirstBookingController(viewModel: BookingViewModel(doctor: vm.doctorDetail, manager: BookingManager(), builder: BookingBuilder()))
        show(controller, sender: nil)
    }
}
