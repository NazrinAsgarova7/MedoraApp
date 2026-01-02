//
//  BookingManager.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 15.12.25.
//

import Foundation

class BookingManager: BookingUseCase {
    let adapter = NetworkingAdapter()
    
    func checkAvailability(endpoint: BookingEndpoint, completion: @escaping ((AvailabilityModel?, Error?) -> Void)) {
        adapter.request(url: endpoint.path, successModel: AvailabilityModel.self, errorModel: nil, method: .get, completion: completion)
    }
    
    func bookDoctor(endpoint: BookingEndpoint, parameters: [String: Any]) async throws -> CoreModel<Booking>? {
        return try await adapter.request(url: endpoint.path, model: Booking.self, method: .post, parameters: parameters, encoding: .json)
    }
}
