//
//  BaseController.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 08.11.25.
//

import UIKit

class BaseController: UIViewController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configVM()
        configUI()
        configConstraint()
    }
    
    func configUI() {
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func configConstraint() {}
    
    func configVM() {}
}
