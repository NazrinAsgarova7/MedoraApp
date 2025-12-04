//
//  Review.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 04.12.25.
//

import Foundation

// MARK: - Datum
struct Review: Codable {
    let id: String?
    let rating: Int?
    let comment, createdAt, userID, doctorID: String?
    let user: User?

    enum CodingKeys: String, CodingKey {
        case id, rating, comment, createdAt
        case userID = "userId"
        case doctorID = "doctorId"
        case user
    }
}
