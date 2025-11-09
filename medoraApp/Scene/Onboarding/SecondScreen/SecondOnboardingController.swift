//
//  SecondController.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 09.11.25.
//

import UIKit

class SecondOnboardingController: BaseController {
    
    private var image: UIImageView = {
        let image = UIImageView(image: UIImage(named: "onboarding2"))
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.hidesBackButton = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let bottomSheetVC = SeondBottomSheet()
        bottomSheetVC.callbackController = {
            self.show(ThirdOnboardingController(), sender: nil)
        }
        bottomSheetVC.isModalInPresentation = true
        bottomSheetVC.modalPresentationStyle = .pageSheet
        
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
