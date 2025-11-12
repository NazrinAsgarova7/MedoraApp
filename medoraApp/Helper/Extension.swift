//
//  Extension.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 08.11.25.
//

import UIKit

extension UIButton {
    
//    
//    func applyGradient(colors: [UIColor],
//                          startPoint: CGPoint = CGPoint(x: 0, y: 0),
//                          endPoint: CGPoint = CGPoint(x: 1, y: 1),
//                       cornerRadius: CGFloat = 16) {
//        
//        
//           let g = CAGradientLayer()
//           g.name = "btnGradientLayer"
//           g.frame = bounds
//           g.colors = colors.map { $0.cgColor }
//           g.startPoint = startPoint
//           g.endPoint = endPoint
//           g.cornerRadius = cornerRadius
//           layer.insertSublayer(g, at: 0)
//           layer.cornerRadius = cornerRadius
//           clipsToBounds = true
//       }
    
    func applyGradient(to view: UIView,
                               colors: [UIColor],
                               start: CGPoint,
                               end: CGPoint,
                               cornerRadius: CGFloat) {
        let key = "btnGradient"

        // Köhnəni sil (reuse zamanı üst-üstə düşməsin)
        view.layer.sublayers?.removeAll(where: { $0.name == key })

        let g = CAGradientLayer()
        g.name = key
        g.colors = colors.map { $0.cgColor }
        g.startPoint = start
        g.endPoint = end
        g.frame = view.bounds                 // <<< ƏN VACİB HİSSƏ
        g.cornerRadius = cornerRadius
        view.layer.insertSublayer(g, at: 0)   // mətnin altında qalsın
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
