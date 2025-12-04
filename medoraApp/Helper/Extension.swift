//
//  Extension.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 08.11.25.
//

import UIKit

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


extension UINavigationController {
    func config() {
        topViewController?.navigationItem.backButtonTitle = ""
        topViewController?.navigationItem.backButtonDisplayMode = .minimal
        navigationBar.tintColor = .black
    }
    
    
}
