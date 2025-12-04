//
//  ReviewCoordinator.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 04.12.25.
//

import Foundation
import UIKit

class ReviewCoordinator: Coordinator {
    var navigationController: UINavigationController
    var id: String
    
    init(navigationController: UINavigationController, id: String) {
        self.navigationController = navigationController
        self.id = id
    }
    
    func start() {
        let controller = ReviewController(vm: ReviewViewModel(manager: ReviewManager(), id: id))
        navigationController.show(controller, sender: nil)
    }
    
    
}
