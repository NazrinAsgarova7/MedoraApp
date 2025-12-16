//
//  Booking.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 16.12.25.
//

import Foundation

struct Booking: Codable {
    let id, date, notes, gender: String?
    let birthDate, userID, doctorID, status: String?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, date, notes, gender, birthDate
        case userID = "userId"
        case doctorID = "doctorId"
        case status, createdAt
    }
}
