//
//  Error.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 03.12.25.
//

import Foundation

// MARK: - DoctorDetailResult
struct Error: Codable {
    let error: String?
    let message: String?
    let formErrors: [String]?
    let fieldErrors: FieldErrors?
}

// MARK: - FieldErrors
struct FieldErrors: Codable {
    let email, password: [String]?
}
