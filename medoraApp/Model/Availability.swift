//
//  Avalibility.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 15.12.25.
//

import Foundation

struct AvailabilityModel: Codable {
    let doctorID, date: String?
    let availableSlots: [String]?
    let bookedSlots: [String]?
    let freeSlots: [String]?
    let totalAvailable, totalBooked, totalFree: Int?

    enum CodingKeys: String, CodingKey {
        case doctorID = "doctorId"
        case date, availableSlots, bookedSlots, freeSlots, totalAvailable, totalBooked, totalFree
    }
}
