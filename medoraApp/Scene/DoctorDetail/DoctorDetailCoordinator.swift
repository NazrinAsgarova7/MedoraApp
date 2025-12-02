//
//  DoctorDetailCoordinator.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 02.12.25.
//

import Foundation
import UIKit

class DoctorDetailCoordinator: Coordinator {
    var navigationController: UINavigationController
    var vm: DoctorViewModel
    
    init(navigationController: UINavigationController, vm: DoctorViewModel) {
        self.navigationController = navigationController
        self.vm = vm
    }
    
    func start() {
        let controller = DoctorDetailController(vm: vm)
        navigationController.show(controller, sender: nil)
    }
}
