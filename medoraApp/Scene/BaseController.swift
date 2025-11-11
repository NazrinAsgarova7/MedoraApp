//
//  BaseController.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 08.11.25.
//

import UIKit

class BaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configVM()
        configUI()
        configConstraint()
    }
    
    func configUI() {}
    
    func configConstraint() {}
    
    func configVM() {}
}
