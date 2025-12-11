//
//  RegisterViewModel.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 13.11.25.
//

import Foundation

class RegisterViewModel{
    let manager: AuthUseCase
    var completion: ((ViewState) -> Void)?

    init(manager: AuthUseCase) {
        self.manager = manager
    }
    
    enum ViewState{
        case success(AuthResult)
        case error(String)
    }
    
    func register(username: String, email: String, password: String){
        let parameters: [String: String] = [
            "name": username,
            "email": email,
            "password": password
        ]
        manager.auth(endpoint: .register, parameters: parameters) { [weak self] data, error in
            if let data {
                if data.user != nil {
                    self?.completion?(ViewState.success(data))
                } else {
                    self?.completion?(ViewState.error("Error"))
                }
            } else if let error {
                if let err = error.error {
                    self?.completion?(ViewState.error(err))
                } else if let _ = error.fieldErrors?.email {
                    self?.completion?(ViewState.error("Invalid email"))
                } else if let _ = error.fieldErrors?.password {
                    self?.completion?(ViewState.error("Password must contain at least 6 character"))
                }
            } else {
                self?.completion?(.error("Internet Error"))
            }
        }
    }
}
