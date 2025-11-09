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
        configVM()
        configUI()
        configConstraint()
    }
    
    func configUI() {}
    
    func configConstraint() {}
    
    func configVM() {}
}
