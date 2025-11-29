//
//  ShimmerView.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 24.11.25.
//

import Foundation
import UIKit

class ShimmerView: UIView {
    private var gradientLayer: CAGradientLayer!
    private var shimmerLayer: CAGradientLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupShimmer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupShimmer()
    }
    
    private func setupShimmer() {
        backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.colors = [
            UIColor(white: 0.85, alpha: 1.0).cgColor,
            UIColor(white: 0.95, alpha: 1.0).cgColor,
            UIColor(white: 0.85, alpha: 1.0).cgColor
        ]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        layer.mask = gradientLayer
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-0.6, -0.3, 0.0]
        animation.toValue   = [1.0, 1.3, 1.6]
        animation.duration = 1.3
        animation.repeatCount = .infinity
        gradientLayer.add(animation, forKey: "shimmerAnimation")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    func startShimmering() {
        isHidden = false
    }
    
    func stopShimmering() {
        isHidden = true
        gradientLayer.removeAllAnimations()
    }
}
