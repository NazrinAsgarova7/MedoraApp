//
//  String+Extension.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 17.12.25.
//

import Foundation

extension Date {
    func yyMMddDateFormat() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = .current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
}
