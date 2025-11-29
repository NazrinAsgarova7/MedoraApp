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
        img.image = UIImage(named: "launch")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var doctorDetailContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var doctorName: UILabel = {
        var l = UILabel()
        l.font = .systemFont(ofSize: 24, weight: .semibold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
  //  var ratingView = ContanierView(image: "", title: <#T##String?#>)
    
    var vm: DoctorViewModel
    
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
        [doctorImage, doctorDetailContainerView].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            doctorImage.topAnchor.constraint(equalTo: view.topAnchor),
            doctorImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            doctorImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            doctorImage.heightAnchor.constraint(equalToConstant: 342),
            
            
        ])
    }
    
    override func configVM() {
        vm.completion = { [weak self] viewstate in
            switch viewstate {
            case .success:
                print(self?.vm.doctorDetail)
            case .error(error: let error):
                print(error)
            }
        }
        
        Task {
            await vm.getDoctorDetail()
        }
    }
}
