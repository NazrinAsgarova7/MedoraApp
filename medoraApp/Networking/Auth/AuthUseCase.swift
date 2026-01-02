//
//  AuthUseCase.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 13.11.25.
//

import Foundation

protocol AuthUseCase {
    func auth(endpoint: AuthEndpoint, parameters: [String: String] ,completion: @escaping ((AuthResult?, Error?) -> Void))
}
