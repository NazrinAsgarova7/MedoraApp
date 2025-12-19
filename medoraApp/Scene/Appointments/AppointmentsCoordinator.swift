//
//  AppointmentsCoordinator.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 19.12.25.
//

import Foundation
import UIKit

class AppointmentsCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.config()
        let controller = AppointmentsController(vm: .init(manager: AppointmentManager()))
        navigationController.show(controller, sender: nil)
    }
}
