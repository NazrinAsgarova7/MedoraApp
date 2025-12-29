//
//  Appointment.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 19.12.25.
//

import Foundation

struct Appointment: Codable {
    let id, date, notes, gender: String?
    let birthDate, userID, doctorID, status: String?
    let createdAt: String?
    let doctor: Doctor?

    enum CodingKeys: String, CodingKey {
        case id, date, notes, gender, birthDate
        case userID = "userId"
        case doctorID = "doctorId"
        case status, createdAt, doctor
    }
}

struct DoctorForAppointment: Codable {
    let id, name: String?
}
