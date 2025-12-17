//
//  BookingUseCase.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 15.12.25.
//

import Foundation
import Alamofire

protocol BookingUseCase {
    func checkAvailability(endpoint: BookingEndpoint, completion: @escaping ((AvailabilityModel?, Error?) -> Void))
    func bookDoctor(endpoint: BookingEndpoint, parameters: Parameters) async throws -> CoreModel<Booking>?
}
