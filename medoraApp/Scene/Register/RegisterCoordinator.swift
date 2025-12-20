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
    var user: [String: String]?
    
    init(navigationController: UINavigationController, user: [String: String]?) {
        self.navigationController = navigationController
        self.user = user
    }
    
    func start() {
        let vc = RegisterController(vm: RegisterViewModel(manager: AuthManager(), user: user))
        vc.navigationItem.hidesBackButton = true
        vc.modalPresentationStyle = .fullScreen
        navigationController.show(vc, sender: nil)
    }
}
