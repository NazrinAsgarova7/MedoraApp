//
//  LoginViewModel.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 14.11.25.
//

import Foundation

class LoginViewModel {
    let manager: AuthUseCase
    var completion: ((ViewState) -> Void)?

    enum ViewState{
        case success(AuthResult)
        case error(String)
    }
    
    init(manager: AuthUseCase) {
        self.manager = manager
    }
    
    func login(email: String, password: String){
        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]
        manager.auth(endpoint: .login, parameters: parameters) { [weak self] data, error in
            if let data {
                self?.completion?(ViewState.success(data))
            } else {
                self?.completion?(ViewState.error("Incorrect usename or password"))
            }
        }
    }
    
    func saveUser(user: AuthResult){
        UserDefaultManager.shared.saveUser(user: user)
    }
}
