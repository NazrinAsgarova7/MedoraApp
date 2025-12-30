//
//  AboutCoordinator.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 27.12.25.
//

import Foundation
import UIKit

class AboutCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.config()
        navigationController.setNavigationBarHidden(false, animated: false)
        let controller = AboutController(vm: AboutViewModel(manager: AboutManager()))
        controller.hidesBottomBarWhenPushed = true
        navigationController.show(controller, sender: nil)
    }
}
