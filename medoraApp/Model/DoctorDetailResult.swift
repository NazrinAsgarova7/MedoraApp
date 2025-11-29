//
//  DoctorDetail.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 29.11.25.
//

import Foundation
// MARK: - DoctorDetailResult
struct DoctorDetailResult: Codable {
    let data: DoctorResult?
}

// MARK: - DataClass
struct DoctorResult: Codable {
    let id, name, specialization: String?
    let photoURL: String?
    let experienceYrs, patientsCount, feeCents, ratingAverage: Int?
    let ratingCount, distanceM: Int?
    let categoryID, availableSlots: String?
    let category: Category?
    
    enum CodingKeys: String, CodingKey {
        case id, name, specialization
        case photoURL = "photoUrl"
        case experienceYrs, patientsCount, feeCents, ratingAverage, ratingCount, distanceM
        case categoryID = "categoryId"
        case availableSlots, category
    }
}
