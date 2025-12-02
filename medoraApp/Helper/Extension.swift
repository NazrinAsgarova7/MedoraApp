//
//  Extension.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 08.11.25.
//

import UIKit

extension UIButton {
    func applyGradient(to view: UIView,
                               colors: [UIColor],
                               start: CGPoint,
                               end: CGPoint,
                               cornerRadius: CGFloat) {
        let key = "btnGradient"
        view.layer.sublayers?.removeAll(where: { $0.name == key })
        let g = CAGradientLayer()
        g.name = key
        g.colors = colors.map { $0.cgColor }
        g.startPoint = start
        g.endPoint = end
        g.frame = view.bounds
        g.cornerRadius = cornerRadius
        view.layer.insertSublayer(g, at: 0)
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
