//
//  BookingCoordinator.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 14.12.25.
//

import Foundation
import UIKit

class BookingCoordinator: Coordinator {
    var navigationController: UINavigationController
    private let builder: BookingBuilder
    private let controller: UIViewController
    
    init(navigationController: UINavigationController, builder: BookingBuilder, controller: UIViewController) {
        self.navigationController = navigationController
        self.builder = builder
        self.controller = controller
    }
    
    func start() {
//        let controller = AddressController(viewModel: .init(coordinator: self))
//        navigationController.show(controller, sender: nil)
    }
}
