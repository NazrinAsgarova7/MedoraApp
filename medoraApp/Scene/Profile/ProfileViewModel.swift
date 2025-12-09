//
//  ProfileViewModel.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 27.11.25.
//

import Foundation
import UIKit

class ProfileViewModel {
    let icons = [("text.document", "Appointments"),
                 ("shield", "Privacy & Security"),
                 ("questionmark", "Help & Support"),
                 ("rectangle.portrait.and.arrow.right", "Logout")]
    
    let iconsForHelp = [
        ("envelope","medora@gmail.com"),
        ("phone","012-789-98-98")
    ]
    func getUserData(key: UserDefaultEnum) -> String {
        UserDefaultManager.shared.getData(key: key)
    }
    
    func saveProfilePhoto(image: UIImage) {
        UserDefaultManager.shared.saveProfileImage(image)
    }
    
    func getProfileImage() -> Data {
        UserDefaultManager.shared.getImage()
    }
}
