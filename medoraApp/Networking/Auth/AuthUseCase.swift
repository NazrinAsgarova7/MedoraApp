//
//  AuthUseCase.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 13.11.25.
//

import Foundation
import Alamofire

protocol AuthUseCase {
    func auth(endpoint: AuthEndpoint, parameters: Parameters ,completion: @escaping ((AuthResult?, Error?) -> Void))
}
