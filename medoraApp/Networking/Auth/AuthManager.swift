//
//  AuthManager.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 13.11.25.
//

import Foundation
import UIKit
import Alamofire

class AuthManager: AuthUseCase{
    let adapter = NetworkingAdapter()
    
    func auth(endpoint: AuthEndpoint, parameters: Parameters ,completion: @escaping ((AuthResult?, String?) -> Void)) {
        adapter.request(url: endpoint.path, model: AuthResult.self, method: .post, parameters: parameters, encoding: JSONEncoding.default, completion:  completion)
    }
}
