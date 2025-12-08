//
//  SecondBookingController.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 08.12.25.
//

import UIKit

class SecondBookingController: BaseController {
    private lazy var physicalInformationLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16, weight: .medium)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    private lazy var genderLabel: UILabel = {
        let l = UILabel()
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
        button.endPoint   = CGPoint(x: 1, y: 1)
        button.corner = 30
        //   button.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var maleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Male", for: .normal)
        button.setImage(UIImage(systemName: "Male"), for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
      //  button.addTarget(self, action: #selector(tappedBookButton), for: .touchUpInside)
        button.backgroundColor = .textBackground
        button.layer.cornerRadius = 24
        button.tintColor = .white
        button.layer.cornerRadius = 28
        //   button.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var femaleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Femaale", for: .normal)
        button.setImage(UIImage(systemName: "Female"), for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
      //  button.addTarget(self, action: #selector(tappedBookButton), for: .touchUpInside)
        button.backgroundColor = .textBackground
        button.layer.cornerRadius = 24
        button.tintColor = .white
        button.layer.cornerRadius = 28
        //   button.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
