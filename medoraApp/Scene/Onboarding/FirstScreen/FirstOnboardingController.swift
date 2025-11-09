//
//  ViewController.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 07.11.25.
//

import UIKit

class FirstOnboardingController: BaseController {
    
    private var image: UIImageView = {
        let image = UIImageView(image: UIImage(named: "onboarding1"))
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let bottomSheetVC = FirstBottomSheet()
        bottomSheetVC.modalPresentationStyle = .pageSheet
        bottomSheetVC.isModalInPresentation = true

        bottomSheetVC.callbackController = {
            self.show(SecondOnboardingController(), sender: nil)
        }
        if let sheet = bottomSheetVC.sheetPresentationController {
            sheet.prefersGrabberVisible = false
               sheet.preferredCornerRadius = 40
                   let customDetent = UISheetPresentationController.Detent.custom(
                       identifier: .init("seventyPercent")
                   ) { context in
                       context.maximumDetentValue * 0.50
                   }

                   sheet.detents = [customDetent]
                   sheet.selectedDetentIdentifier = customDetent.identifier
    }
        present(bottomSheetVC, animated: true)
    }
    
    override func configConstraint() {
        view.addSubview(image)
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.topAnchor),
            image.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
}

