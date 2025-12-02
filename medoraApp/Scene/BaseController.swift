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
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        view.backgroundColor = .systemBackground
        configVM()
        configUI()
        configConstraint()
    }
    
    func configUI() {}
    
    func configConstraint() {}
    
    func configVM() {}
}
