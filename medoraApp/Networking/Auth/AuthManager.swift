//
//  AuthManager.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 13.11.25.
//

import Foundation

class AuthManager: AuthUseCase{
    let adapter = NetworkingAdapter()
    
    func auth(endpoint: AuthEndpoint, parameters: [String: String] ,completion: @escaping ((AuthResult?, Error?) -> Void)) {
        adapter.request(url: endpoint.path, successModel: AuthResult.self, errorModel: Error.self, method: .post, parameters: parameters, encoding: .json, completion: completion)
    }
}
