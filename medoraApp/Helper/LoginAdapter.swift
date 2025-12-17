//
//  LoginAdapter.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 18.12.25.
//

import Foundation
import GoogleSignIn

enum LoginMethod {
    case apple, google, facebook
}

class LoginAdapter {
//    var controller: UIViewController?
//
//    init(controller: UIViewController?) {
//        self.controller = controller
//    }
    
//    var controller = UIViewController()
    
    enum ViewState {
        case error(message: String)
        case success
    }
    
    var errorCompletion: ((String) -> Void)?
    var successCompletion: ((User) -> Void)?
    
    var completion: ((ViewState) -> Void)?
    
    func login(controller: UIViewController, method: LoginMethod) {
        switch method {
        case .apple:
            loginWithApple(controller: controller)
        case .facebook:
            loginWithFacebook()
        case .google:
            loginWithGoogle(controller: controller)
        }
    }
    
    private func loginWithApple(controller: UIViewController) {
        
    }
    
    private func loginWithFacebook() {
        
    }
    
    private func loginWithGoogle(controller: UIViewController) {
        GIDSignIn.sharedInstance.signIn(withPresenting: controller) { [weak self] result, error in
            guard let self else { return }
            if let error {
//                self.errorCompletion?(error.localizedDescription)
                self.completion?(.error(message: error.localizedDescription))
            } else if let result {
                //                self.successCompletion?(user)
                self.completion?(.success)
            }
        }
    }
}
