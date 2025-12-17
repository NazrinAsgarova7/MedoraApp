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
    let adapter = LoginAdapter()
    
    enum ViewState{
        case success(AuthResult)
        case error(String)
    }
    
    init(manager: AuthUseCase) {
        self.manager = manager
        adapter.completion = { viewstate in
            print("success")
        }
    }
    
    func login(email: String, password: String){
        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]
        manager.auth(endpoint: .login, parameters: parameters) { [weak self] data, error in
            if let data {
                self?.completion?(ViewState.success(data))
            } else if let error {
                self?.completion?(ViewState.error("Incorrect usename or password"))
            } else {
                self?.completion?(.error("Internet Error"))
            }
        }
    }
    
    func saveUser(user: AuthResult){
        UserDefaultManager.shared.saveUser(user: user)
    }
    
    func loginWithGoogle() {
        adapter.login(controller: LoginController(viewModel: self), method: .google)
    }
}
