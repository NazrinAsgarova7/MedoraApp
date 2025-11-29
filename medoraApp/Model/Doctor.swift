//
//  DoctorResult.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 18.11.25.
//

import Foundation

// MARK: - Doctor
struct Doctor: Codable {
    let id, name, specialization: String?
    let photoURL: String?
    let experienceYrs, patientsCount, feeCents: Int?
    let ratingAverage: Double?
    let ratingCount, distanceM: Int?
    let categoryID: String?
    let availableSlots: String?

    enum CodingKeys: String, CodingKey {
        case id, name, specialization
        case photoURL = "photoUrl"
        case experienceYrs, patientsCount, feeCents, ratingAverage, ratingCount, distanceM
        case categoryID = "categoryId"
        case availableSlots
    }
}
