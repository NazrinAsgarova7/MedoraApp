//
//  GradientButton.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 03.12.25.
//

import Foundation
import UIKit

final class GradientButton: UIButton {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    private var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }

    var gradientColors: [UIColor] = [] { didSet { updateGradient() } }
    var startPoint: CGPoint = CGPoint(x: 0, y: 0) { didSet { updateGradient() } }
    var endPoint: CGPoint   = CGPoint(x: 1, y: 1) { didSet { updateGradient() } }
    var corner: CGFloat = 0 { didSet { layer.cornerRadius = corner; layer.masksToBounds = true } }

    private func updateGradient() {
        gradientLayer.colors = gradientColors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
    }
}
