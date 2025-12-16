//
//  SecondBookingController.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 08.12.25.
//

import UIKit

class SecondBookingController: BaseController {
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var doctorDetailContainerView: DetailView = {
        let view = DetailView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.05
        view.layer.shadowRadius = 8
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.masksToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var physicalInformationLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16, weight: .medium)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var genderLabel: UILabel = {
        let l = UILabel()
        l.text = "Gender"
        l.font = .systemFont(ofSize: 14, weight: .medium)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var birthdayLabel: UILabel = {
        let l = UILabel()
        l.text = "Date of Birth"
        l.font = .systemFont(ofSize: 14, weight: .medium)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var mainComplaintLabel: UILabel = {
        let l = UILabel()
        l.text = "Main Complaint"
        l.font = .systemFont(ofSize: 14, weight: .medium)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var continueButton: UIButton = {
        let button = GradientButton()
        button.setTitle("Continue", for: .normal)
        button.gradientColors = [UIColor(named: "buttonStart") ?? .gray,
                                 UIColor(named: "buttonEnd") ?? .gray]
        button.tintColor = .white
        button.startPoint = CGPoint(x: 0, y: 0)
        button.endPoint = CGPoint(x: 1, y: 1)
        button.corner = 30
        button.addTarget(self, action: #selector(tappedContinueButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var maleButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Male", for: .normal)
        button.setImage(UIImage(named: "male"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .textBackground
        button.layer.cornerRadius = 24
        button.tintColor = .white
        button.layer.cornerRadius = 28
        button.addTarget(self, action: #selector(tappedGenderButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var femaleButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Female", for: .normal)
        button.setImage(UIImage(named: "female"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.addTarget(self, action: #selector(tappedGenderButton(_:)), for: .touchUpInside)
        button.backgroundColor = .textBackground
        button.layer.cornerRadius = 24
        button.tintColor = .white
        button.layer.cornerRadius = 28
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var birthdayButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle(" Select birthday", for: .normal)
        btn.setImage(UIImage(systemName: "calendar"), for: .normal)
        btn.backgroundColor = .textBackground
        btn.tintColor = .black
        btn.setTitleColor(.gray, for: .normal)
        btn.layer.cornerRadius = 8
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.addTarget(self, action: #selector(showPicker), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var pickerContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.maximumDate = Date()
        picker.minimumDate = Calendar.current.date(byAdding: .year, value: -100, to: Date())
        picker.locale = Locale(identifier: "az_AZ")
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private lazy var additionalInfoTextView: UITextView = {
        let text = UITextView()
        text.textContainerInset = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8)
        text.delegate = self
        text.backgroundColor = .textBackground
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var textFieldContainerView: UIView = {
        var view = UIView()
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var doneButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Done", for: .normal)
        b.titleLabel?.font = .boldSystemFont(ofSize: 18)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(hidePicker), for: .touchUpInside)
        return b
    }()
    
    private let vm: BookingViewModel
    private var containerBottomConstraint: NSLayoutConstraint!
    
    init(viewModel: BookingViewModel) {
        vm = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configConstraint() {
        view.addSubview(scrollView)
        view.addSubview(pickerContainer)
        
        scrollView.addSubview(contentView)
        
        [doctorDetailContainerView, physicalInformationLabel, genderLabel, continueButton, maleButton, femaleButton, birthdayButton, textFieldContainerView, birthdayLabel, mainComplaintLabel].forEach { contentView.addSubview($0) }
        
        textFieldContainerView.addSubview(additionalInfoTextView)
        [datePicker, doneButton].forEach { pickerContainer.addSubview($0) }
        
        containerBottomConstraint = pickerContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 350)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            pickerContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pickerContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerBottomConstraint,
            pickerContainer.heightAnchor.constraint(equalToConstant: 240),
            
            doneButton.topAnchor.constraint(equalTo: pickerContainer.topAnchor, constant: 4),
            doneButton.trailingAnchor.constraint(equalTo: pickerContainer.trailingAnchor, constant: -16),
            
            datePicker.topAnchor.constraint(equalTo: doneButton.bottomAnchor, constant: 4),
            datePicker.leadingAnchor.constraint(equalTo: pickerContainer.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: pickerContainer.trailingAnchor),
            datePicker.bottomAnchor.constraint(equalTo: pickerContainer.bottomAnchor),
            
            doctorDetailContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.914),
            doctorDetailContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.128),
            doctorDetailContainerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            doctorDetailContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            
            physicalInformationLabel.topAnchor.constraint(equalTo: doctorDetailContainerView.bottomAnchor, constant: 32),
            physicalInformationLabel.leadingAnchor.constraint(equalTo: doctorDetailContainerView.leadingAnchor),
            physicalInformationLabel.trailingAnchor.constraint(equalTo: doctorDetailContainerView.trailingAnchor),
            
            genderLabel.topAnchor.constraint(equalTo: physicalInformationLabel.bottomAnchor, constant: 24),
            genderLabel.leadingAnchor.constraint(equalTo: physicalInformationLabel.leadingAnchor),
            
            birthdayLabel.topAnchor.constraint(equalTo: maleButton.bottomAnchor, constant: 24),
            birthdayLabel.leadingAnchor.constraint(equalTo: physicalInformationLabel.leadingAnchor),
            
            maleButton.widthAnchor.constraint(equalToConstant: (view.frame.width - 40) / 2),
            maleButton.heightAnchor.constraint(equalToConstant: 56),
            maleButton.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 8),
            maleButton.leadingAnchor.constraint(equalTo: genderLabel.leadingAnchor),
            
            femaleButton.widthAnchor.constraint(equalToConstant: (view.frame.width - 40) / 2),
            femaleButton.heightAnchor.constraint(equalToConstant: 56),
            femaleButton.topAnchor.constraint(equalTo: physicalInformationLabel.bottomAnchor, constant: 52),
            femaleButton.leadingAnchor.constraint(equalTo: maleButton.trailingAnchor, constant: 8),
            
            birthdayButton.leadingAnchor.constraint(equalTo: maleButton.leadingAnchor),
            birthdayButton.trailingAnchor.constraint(equalTo: femaleButton.trailingAnchor),
            birthdayButton.heightAnchor.constraint(equalToConstant: 56),
            birthdayButton.topAnchor.constraint(equalTo: maleButton.bottomAnchor, constant: 52),
            
            mainComplaintLabel.leadingAnchor.constraint(equalTo: birthdayButton.leadingAnchor),
            mainComplaintLabel.topAnchor.constraint(equalTo: birthdayButton.bottomAnchor, constant: 24),
            
            textFieldContainerView.topAnchor.constraint(equalTo: mainComplaintLabel.bottomAnchor, constant: 8),
            textFieldContainerView.leadingAnchor.constraint(equalTo: birthdayButton.leadingAnchor),
            textFieldContainerView.trailingAnchor.constraint(equalTo: birthdayButton.trailingAnchor),
            textFieldContainerView.heightAnchor.constraint(equalToConstant: 102),
            
            additionalInfoTextView.leadingAnchor.constraint(equalTo: textFieldContainerView.leadingAnchor),
            additionalInfoTextView.bottomAnchor.constraint(equalTo: textFieldContainerView.bottomAnchor),
            additionalInfoTextView.trailingAnchor.constraint(equalTo: textFieldContainerView.trailingAnchor),
            additionalInfoTextView.topAnchor.constraint(equalTo: textFieldContainerView.topAnchor),
            
            continueButton.heightAnchor.constraint(equalToConstant: 56),
            continueButton.topAnchor.constraint(equalTo: additionalInfoTextView.bottomAnchor, constant: 32),
            continueButton.leadingAnchor.constraint(equalTo: additionalInfoTextView.leadingAnchor),
            continueButton.trailingAnchor.constraint(equalTo: additionalInfoTextView.trailingAnchor),
            
            contentView.heightAnchor.constraint(equalToConstant: 750)
        ])
    }
    
    override func configUI() {
        navigationController?.config()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        self.title = "Doctor Booking"
        physicalInformationLabel.text = "Physical Information"
        doctorDetailContainerView.configUI(doctor: vm.doctor)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func showPicker() {
        containerBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func hidePicker() {
        containerBottomConstraint.constant = 350
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = formatter.string(from: datePicker.date)
        birthdayButton.setTitle(selectedDate, for: .normal)
        vm.builder.setBirthday(selectedDate)
    }
    
    @objc private func tappedGenderButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            sender.setTitleColor(.black, for: .normal)
            sender.backgroundColor = .textBackground
            sender.layer.borderWidth = 0
        } else {
            if sender.titleLabel?.text == " Male" {
                femaleButton.isSelected = false
                femaleButton.setTitleColor(.black, for: .normal)
                femaleButton.backgroundColor = .textBackground
                femaleButton.layer.borderWidth = 0
            } else {
                maleButton.isSelected = false
                maleButton.setTitleColor(.black, for: .normal)
                maleButton.backgroundColor = .textBackground
                maleButton.layer.borderWidth = 0
            }
            sender.isSelected = true
            sender.layer.borderWidth = 1
            sender.layer.borderColor = UIColor(named: "buttonStart")?.cgColor
            sender.backgroundColor = .informationViewBg
            sender.setTitleColor(.buttonStart, for: .normal)
            sender.titleLabel?.text == " Male" ? vm.builder.setGender(.male) : vm.builder.setGender(.female)
        }
        
    }
    
    @objc private func tappedContinueButton() {
        let controller = ThirdBookingController(viewModel: vm)
        show(controller, sender: nil)
    }
}

extension SecondBookingController: UITextViewDelegate {
    func textView(
        _ textView: UITextView,
        shouldChangeTextIn range: NSRange,
        replacementText text: String
    ) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            vm.builder.setComment(textView.text)
            return false
        }
        vm.builder.setComment(textView.text)
        return textView.text.count + text.count - range.length <= 200
    }
}
