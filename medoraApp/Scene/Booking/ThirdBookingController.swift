//
//  ThirdBookingController.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 14.12.25.
//

import UIKit

class ThirdBookingController: BaseController {
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
    private lazy var calendarView: UICalendarView = {
        let calendarView = UICalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.delegate = self
        calendarView.selectionBehavior = UICalendarSelectionSingleDate(delegate: self)
        calendarView.calendar = Calendar(identifier: .gregorian)
        calendarView.locale = Locale.current
        return calendarView
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
    private lazy var picker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    private lazy var doneButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Done", for: .normal)
        b.titleLabel?.font = .boldSystemFont(ofSize: 18)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(hidePicker), for: .touchUpInside)
        return b
    }()
    private lazy var timeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle(" Select time", for: .normal)
        btn.setImage(UIImage(systemName: "clock"), for: .normal)
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
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var bookButton: UIButton = {
        let button = GradientButton()
        button.setTitle("Book", for: .normal)
        button.gradientColors = [UIColor(named: "buttonStart") ?? .gray,
                                 UIColor(named: "buttonEnd") ?? .gray]
        button.tintColor = .white
        button.startPoint = CGPoint(x: 0, y: 0)
        button.endPoint = CGPoint(x: 1, y: 1)
        button.corner = 30
        button.addTarget(self, action: #selector(tappedBookButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var freeSlots: [String] = []
    var onSelect: ((String) -> Void)?
    private let vm: BookingViewModel
    private var containerBottomConstraint: NSLayoutConstraint!
    
    
    private var selectedDay: Date?
    private var selectedTime: String?
    
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
        [calendarView, doctorDetailContainerView, timeButton,bookButton].forEach { contentView.addSubview( $0) }
        [picker, doneButton].forEach { pickerContainer.addSubview($0) }
        containerBottomConstraint = pickerContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 350)
        
        NSLayoutConstraint.activate([
            timeButton.leadingAnchor.constraint(equalTo: calendarView.leadingAnchor),
            timeButton.trailingAnchor.constraint(equalTo: calendarView.trailingAnchor),
            timeButton.heightAnchor.constraint(equalToConstant: 56),
            timeButton.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 52),
            
            pickerContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pickerContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerBottomConstraint,
            pickerContainer.heightAnchor.constraint(equalToConstant: 240),
            
            doneButton.topAnchor.constraint(equalTo: pickerContainer.topAnchor, constant: 4),
            doneButton.trailingAnchor.constraint(equalTo: pickerContainer.trailingAnchor, constant: -16),
            
            picker.topAnchor.constraint(equalTo: doneButton.bottomAnchor, constant: 4),
            picker.leadingAnchor.constraint(equalTo: pickerContainer.leadingAnchor),
            picker.trailingAnchor.constraint(equalTo: pickerContainer.trailingAnchor),
            picker.bottomAnchor.constraint(equalTo: pickerContainer.bottomAnchor),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            calendarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            calendarView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            calendarView.topAnchor.constraint(equalTo: doctorDetailContainerView.bottomAnchor, constant: 32),
            calendarView.heightAnchor.constraint(equalToConstant: 300),
            
            contentView.heightAnchor.constraint(equalToConstant: 800),
            
            doctorDetailContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.914),
            doctorDetailContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.128),
            doctorDetailContainerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            doctorDetailContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            
            bookButton.heightAnchor.constraint(equalToConstant: 56),
            bookButton.topAnchor.constraint(equalTo: timeButton.bottomAnchor, constant: 32),
            bookButton.leadingAnchor.constraint(equalTo: timeButton.leadingAnchor),
            bookButton.trailingAnchor.constraint(equalTo: timeButton.trailingAnchor),
        ])
    }
    
    override func configUI() {
        self.title = "Doctor Booking"
        doctorDetailContainerView.configUI(doctor: vm.doctor)
    }
    
    override func configVM() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = .current
        formatter.dateFormat = "yyyy-MM-dd"
        vm.checkAvailability(date: formatter.string(from: Date()))
        
        vm.completion = { viewState in
            switch viewState {
            case .error(let error):
                print(error)
            case .success:
                self.freeSlots = self.vm.availabilityModel?.freeSlots ?? []
                self.picker.reloadAllComponents()
            }
        }
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
        let row = picker.selectedRow(inComponent: 0)
        guard freeSlots.indices.contains(row) else { return }
        
        let time = freeSlots[row]
        selectedTime = time
        timeButton.setTitle(time, for: .normal)
    }
    
    @objc private func tappedBookButton() {
        guard let selectedDay else { return }
        guard let selectedTime else { return }
        
        let parts = selectedTime.split(separator: ":")
        guard parts.count == 2,
              let hour = Int(parts[0]),
              let minute = Int(parts[1]) else { return }
        
        var localCal = Calendar(identifier: .gregorian)
        localCal.timeZone = .current
        let day = localCal.dateComponents([.year, .month, .day], from: selectedDay)
        var utcCal = Calendar(identifier: .gregorian)
        utcCal.timeZone = TimeZone(secondsFromGMT: 0)!
        
        var comps = DateComponents()
        comps.year = day.year
        comps.month = day.month
        comps.day = day.day
        comps.hour = hour
        comps.minute = minute
        comps.second = 0
        
        guard let utcDateTime = utcCal.date(from: comps) else { return }
        
        let iso = ISO8601DateFormatter()
        iso.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        iso.timeZone = TimeZone(secondsFromGMT: 0)!
        
        let isoString = iso.string(from: utcDateTime)
        
        vm.builder.setReservDate(date: isoString)
        Task {
            await vm.bookDate()
        }
    }
    
}

extension ThirdBookingController: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        if let date = dateComponents?.date {
            selectedDay = date
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = .current
            formatter.dateFormat = "yyyy-MM-dd"
            vm.checkAvailability(date: formatter.string(from: date))
        }
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate,
                       canSelectDate dateComponents: DateComponents?) -> Bool {
        guard
            let dateComponents,
            let date = dateComponents.date
        else { return false }
        
        let cal = calendarView.calendar
        let start = cal.startOfDay(for: Date())
        let oneMonthLater = cal.date(byAdding: .month, value: 1, to: start)!
        let endExclusive = cal.date(byAdding: .day, value: 1, to: oneMonthLater)!
        return (date >= start) && (date < endExclusive)
    }
}

extension ThirdBookingController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { freeSlots.count }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        freeSlots[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        onSelect?(freeSlots[row])
    }
}
