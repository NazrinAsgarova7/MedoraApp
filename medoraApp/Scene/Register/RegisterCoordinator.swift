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
    var viewController: UIViewController
    
    init(navigationController: UINavigationController, vc: UIViewController) {
        self.navigationController = navigationController
        self.viewController = vc
    }
    
    func start() {
        let vc = UINavigationController(rootViewController: RegisterController(vm: RegisterViewModel(manager: AuthManager())))
        vc.modalPresentationStyle = .fullScreen
        viewController.show(vc, sender: nil)
    }
}
