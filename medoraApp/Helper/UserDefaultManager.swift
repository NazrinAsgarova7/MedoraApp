//
//  UserDefaultManager.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 14.11.25.
//

import Foundation
import UIKit

enum UserDefaultEnum: String, CaseIterable {
   case token, email, name, id, profile
}

class UserDefaultManager {
    static let shared = UserDefaultManager()
    private init() {}
    
    func saveUser(user: AuthResult) {
        UserDefaults.standard.set(user.token, forKey: UserDefaultEnum.token.rawValue)
        UserDefaults.standard.set(user.user?.email, forKey: UserDefaultEnum.email.rawValue)
        UserDefaults.standard.set(user.user?.name, forKey: UserDefaultEnum.name.rawValue)
        UserDefaults.standard.set(user.user?.id, forKey: UserDefaultEnum.id.rawValue)
    }
    
    func isLogged() -> Bool {
        return UserDefaults.standard.string(forKey: UserDefaultEnum.id.rawValue) != nil
    }
    
    func removeAll() {
        UserDefaultEnum.allCases.forEach {
            if $0 != .profile {
                UserDefaults.standard.removeObject(forKey: $0.rawValue)
            }
        }
    }
    
    func getData(key: UserDefaultEnum) -> String {
        return UserDefaults.standard.string(forKey: key.rawValue) ?? ""
    }
    
    func saveProfileImage(_ image: UIImage) {
           guard let data = image.jpegData(compressionQuality: 0.8) else { return }
        UserDefaults.standard.set(data, forKey: UserDefaultEnum.profile.rawValue)
       }
    
    func getImage() -> Data {
        return UserDefaults.standard.data(forKey: UserDefaultEnum.profile.rawValue) ?? Data()
    }
}
