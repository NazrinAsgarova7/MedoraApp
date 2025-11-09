//
//  Extension.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 08.11.25.
//

import UIKit

extension UIButton {
    func applyGradient(colors: [UIColor],
                          startPoint: CGPoint = CGPoint(x: 0, y: 0),
                          endPoint: CGPoint = CGPoint(x: 1, y: 1),
                       cornerRadius: CGFloat = 16) {
           let g = CAGradientLayer()
           g.name = "btnGradientLayer"
           g.frame = bounds
           g.colors = colors.map { $0.cgColor }
           g.startPoint = startPoint
           g.endPoint = endPoint
           g.cornerRadius = cornerRadius
           layer.insertSublayer(g, at: 0)
           layer.cornerRadius = cornerRadius
           clipsToBounds = true
       }
}


extension UILabel {
    func set( line: CGFloat = 0) {
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
