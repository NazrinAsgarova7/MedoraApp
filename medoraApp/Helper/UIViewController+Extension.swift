//
//  UIView+Extension.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 04.12.25.
//

import Foundation
import UIKit
import Cosmos

extension UIViewController {
    
    func showRatingAlert(completion: @escaping (Int, String?) -> Void) {
        
        let alert = UIAlertController(title: "Tap to Rate",
                                      message: "\n\n",
                                      preferredStyle: .alert)
        let cosmosView = CosmosView()
        cosmosView.rating = 0
        cosmosView.settings.fillMode = .full
        cosmosView.settings.starSize = 40
        cosmosView.settings.starMargin = 10
        cosmosView.settings.filledColor = .systemOrange
        cosmosView.settings.emptyColor = .systemGray4
        cosmosView.settings.filledBorderColor = .systemOrange
        cosmosView.settings.emptyBorderColor = .systemGray4
        cosmosView.translatesAutoresizingMaskIntoConstraints = false
        
        alert.view.addSubview(cosmosView)
        
        NSLayoutConstraint.activate([
            cosmosView.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor),
            cosmosView.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 50),
            cosmosView.widthAnchor.constraint(equalToConstant: 240),
            cosmosView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        let submit = UIAlertAction(title: "Send", style: .default) { _ in
            let rating = Int(cosmosView.rating)
            let comment = alert.textFields?.first?.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            completion(rating, comment)
        }
        submit.isEnabled = false

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(submit)

        func updateSubmitState() {
            let text = alert.textFields?.first?.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            submit.isEnabled = (Int(cosmosView.rating) > 0) && !text.isEmpty
        }

        alert.addTextField { tf in
            tf.placeholder = "Add comment..."
            tf.borderStyle = .roundedRect
            tf.font = .systemFont(ofSize: 15)
            tf.addAction(UIAction { _ in
                updateSubmitState()
            }, for: .editingChanged)
        }

        cosmosView.didFinishTouchingCosmos = { _ in
            updateSubmitState()
        }
        self.present(alert, animated: true)
    }
    
    func showAlert(title: String = "Xəta",  message: String, okTitle: String = "Tamam", onOk: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okTitle, style: .default) { _ in
            onOk?()
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
