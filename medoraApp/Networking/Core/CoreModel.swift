//
//  CoreModel.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 21.11.25.
//

import Foundation

struct CoreModel<T: Codable>: Codable {
    let data: T?
    let pagination: Pagination?
}

// MARK: - Pagination
struct Pagination: Codable {
    let page, limit, total, totalPages: Int?
}
