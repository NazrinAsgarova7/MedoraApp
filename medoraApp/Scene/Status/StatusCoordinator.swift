//
//  StatusCoordinator.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 03.12.25.
//

import Foundation
import UIKit

class StatusCoordinator: Coordinator {
    var navigationController: UINavigationController
    var configFor: Status
    
    init(navigationController: UINavigationController, configFor: Status) {
        self.navigationController = navigationController
        self.configFor = configFor
    }
    
    func start() {
        let statusVc = StatusController()
        statusVc.modalPresentationStyle = .overFullScreen
        statusVc.modalTransitionStyle = .crossDissolve
        statusVc.configForSuccess(status: configFor)
        navigationController.present(statusVc, animated: true)
    }
}
