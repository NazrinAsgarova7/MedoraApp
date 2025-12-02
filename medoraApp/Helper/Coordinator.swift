//
//  Coordinator.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 02.12.25.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get }
    
    func start()
}
