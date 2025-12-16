//
//  BookingViewModel.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 06.12.25.
//

import Foundation

class BookingViewModel {
    enum ViewState {
        case success
        case error(String)
    }
    let manager: BookingManager
    var completion: ((ViewState) -> Void)?
    var doctor: Doctor?
    var availabilityModel: AvailabilityModel?
    var bookingModel: Booking?
    let builder: BookingBuilder
    
    init(doctor: Doctor?, manager: BookingManager, builder: BookingBuilder) {
        self.doctor = doctor
        self.manager = manager
        self.builder = builder
    }
    
    func checkAvailability(date: String) {
        manager.checkAvailability(endpoint: .checkAvability(id: doctor?.id ?? "", date: date)) { data, error in
            if let data {
                self.availabilityModel = data
                self.completion?(.success)
            } else if let error {
                self.completion?(.error(error.error ?? ""))
            }
        }
    }
    
    func bookDate() async {
        do {
            let result = try await manager.bookDoctor(endpoint: .bookDoctor(id: doctor?.id ?? ""), parameters: builder.build())
            print(builder.build())
            bookingModel = result?.data
            Task { @MainActor in
                completion?(.success)
            }
        } catch {
            Task { @MainActor in
                completion?(.error(error.localizedDescription))
            }
        }
    }
}
