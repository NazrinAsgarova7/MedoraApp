//
//  RegisterCoordinator.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 02.12.25.
//

import Foundation
import UIKit

class RegisterCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = RegisterController(vm: RegisterViewModel(manager: AuthManager()))
        vc.modalPresentationStyle = .fullScreen
        navigationController.show(vc, sender: nil)
    }
}
