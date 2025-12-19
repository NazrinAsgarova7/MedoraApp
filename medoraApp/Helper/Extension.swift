//
//  Extension.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 08.11.25.
//

import UIKit
import Kingfisher

extension UILabel {
    func set(line: CGFloat = 0) {
        let p = NSMutableParagraphStyle()
        p.lineSpacing = line
        p.alignment = self.textAlignment
        
        let attr = NSAttributedString(
            string: self.text ?? "",
            attributes: [
                .font: self.font as Any,
                .foregroundColor: self.textColor as Any,
                .paragraphStyle: p
            ]
        )
        self.attributedText = attr
        self.numberOfLines = 0
    }
    
}

extension String {
    func timeAgo() -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let formattedDate = formatter.date(from: self)
        
        guard let date = formattedDate else { return "" }
        let now = Date()
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date, to: now)
        
        if let year = components.year, year > 0 {
            return "\(year) years ago"
        } else if let month = components.month, month > 0 {
            return "\(month) months ago"
        } else if let day = components.day, day > 0 {
            return "\(day) days ago"
        } else if let hour = components.hour, hour > 0 {
            return "\(hour) hours ago"
        } else if let minute = components.minute, minute > 0 {
            return "\(minute) min ago"
        } else {
            return "now"
        }
    }
    
    func changeFormatddMMyyyy() -> String? {
        let datePart = self.split(separator: "T").first.map(String.init) ?? self
        let parts = datePart.split(separator: "-")
        guard parts.count == 3 else { return nil }
        return "\(parts[2]).\(parts[1]).\(parts[0])"
    }
    
}

extension UINavigationController {
    func config() {
        topViewController?.navigationItem.backButtonTitle = ""
        topViewController?.navigationItem.backButtonDisplayMode = .minimal
        navigationBar.tintColor = .black
    }
}
extension UIImageView {
    func loadImage(image: String) {
        self.kf.setImage(with: URL(string: image))
    }
}
