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
    var viewController: UIViewController
    
    init(navigationController: UINavigationController, vc: UIViewController) {
        self.navigationController = navigationController
        self.viewController = vc
    }
    
    func start() {
        let controller = UINavigationController(rootViewController: LoginController(viewModel: LoginViewModel(manager: AuthManager())))
        controller.modalPresentationStyle = .fullScreen
        viewController.show(controller, sender: nil)
    }
}
