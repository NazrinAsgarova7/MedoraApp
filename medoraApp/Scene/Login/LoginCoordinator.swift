//
//  LoginCoordinator.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 02.12.25.
//

import Foundation
import UIKit

class LoginCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = UINavigationController(rootViewController: LoginController(viewModel: LoginViewModel(manager: AuthManager())))
        controller.modalPresentationStyle = .fullScreen
        navigationController.show(controller, sender: nil)
    }
    
    
}
