//
//  ProfileViewModel.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 27.11.25.
//

import Foundation
import UIKit

class ProfileViewModel {
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
