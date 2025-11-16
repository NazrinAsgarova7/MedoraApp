//
//  Register.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 13.11.25.
//

import Foundation

// MARK: - RegisterResult
struct AuthResult: Codable {
    let token: String?
    let user: User?
}

// MARK: - User
struct User: Codable {
    let id, name, email: String?
}
