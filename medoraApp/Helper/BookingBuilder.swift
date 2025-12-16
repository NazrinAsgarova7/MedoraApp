//
//  PurchaseBuilder.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 05.12.25.
//

import Foundation
enum Gender: String {
    case male, female
}
class BookingBuilder {
    private var gender: String?
    private var fullname: String?
    private var email: String?
    private var phoneNumber: String?
    private var dateOfBirht: String?
    private var additionalComment: String?
    private var rezervDate: String?
    
    func setUser(fullname: String?, email: String?, phoneNumber: String?) {
        self.fullname = fullname
        self.email = email
        self.phoneNumber = phoneNumber
    }
    
    func setGender(_ gender: Gender) {
        self.gender = gender.rawValue
    }
    
    func setBirthday(_ birthDate: String) {
        self.dateOfBirht = birthDate
    }
    
    func setComment(_ comment: String) {
        self.additionalComment = comment
    }
    
    func setReservDate(date: String) {
        self.rezervDate = date
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
