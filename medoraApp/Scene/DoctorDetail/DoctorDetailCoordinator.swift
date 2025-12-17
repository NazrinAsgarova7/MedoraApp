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
    private var doctor: Doctor
    private var builder: BookingBuilder
    
    init(navigationController: UINavigationController, doctor: Doctor, builder: BookingBuilder) {
        self.navigationController = navigationController
        self.doctor = doctor
        self.builder = builder
    }
    
    func start() {
        let controller = DoctorDetailController(vm: DoctorViewModel( manager: DoctorDetailManager(), doctorId: doctor.id ?? "", coordinator: self))
        controller.hidesBottomBarWhenPushed = true
        navigationController.show(controller, sender: nil)
    }
    
    func showPersonalInformationScreen() {
        let controller = BookingPersonalBioController(coordinator: self, doctor: doctor)
        navigationController.show(controller, sender: nil)
    }
    
    func showPyhsicalInformationScreen() {
        let controller = BookingPhysicalInfoController(coordinator: self, builder: builder, doctor: doctor)
        navigationController.show(controller, sender: nil)
    }
    
    func showCalendarScreen() {
        let controller = BookingCalendarController(viewModel: .init(doctor: doctor,
                                                                    manager: BookingManager(),
                                                                    builder: builder))
        navigationController.show(controller, sender: nil)
    }
}
