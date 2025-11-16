//
//  UserDefaultManager.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 14.11.25.
//

import Foundation

enum UserDefaultEnum: String{
   case token, email, name, id
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
}
