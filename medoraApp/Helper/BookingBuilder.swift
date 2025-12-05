//
//  PurchaseBuilder.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 05.12.25.
//

import Foundation

class BookingBuilder {
    private var gender: String?
    private var fullname: String?
    private var email: String?
    private var phoneNumber: String?
    private var dateOfBirht: Date?
    private var additionalComment: String?
    private var rezervDate: Date?
    
    func setUser(fullname: String?, email: String?, phoneNumber: String?) {
        self.fullname = fullname
        self.email = email
        self.phoneNumber = phoneNumber
    }
    
    func setGenderAndComments(gender: String?, birthdate: Date?, comment: String) {
        self.gender = gender
        self.dateOfBirht = birthdate
        self.additionalComment = comment
    }
    
    func setReservDate(day: String, time: String) {
    
    }
    
    func build() -> [String: Any] {
        guard let date = rezervDate,
              let comment = additionalComment,
              let gender = gender,
              let birthDate = dateOfBirht
        else { return [:]}
        return [ "userId":  UserDefaultManager.shared.getData(key: .id),
                 "date": date,
                 "notes": comment,
                 "gender": gender,
                 "birthDate": birthDate]
    }
}
