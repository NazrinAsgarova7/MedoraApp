//
//  AboutModel.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 30.12.25.
//

// MARK: - DataClass
struct AboutModel: Codable {
    let hospitalName: String?
    let hero: Hero?
    let mission: Mission?
    let why: Why?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case hospitalName = "hospital_name"
        case hero, mission, why
        case updatedAt = "updated_at"
    }
}

// MARK: - Hero
struct Hero: Codable {
    let title, subtitle: String?
    let imageURL: String?
    let leftIcon: String?

    enum CodingKeys: String, CodingKey {
        case title, subtitle
        case imageURL = "image_url"
        case leftIcon = "left_icon"
    }
}

// MARK: - Mission
struct Mission: Codable {
    let title, text: String?
}

// MARK: - Why
struct Why: Codable {
    let title: String?
    let items: [Item]?
}

// MARK: - Item
struct Item: Codable {
    let id: Int?
    let icon, title, subtitle: String?
    let order: Int?
}
