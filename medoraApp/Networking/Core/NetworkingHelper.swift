//
//  NetworkingHelper.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 13.11.25.
//

import Foundation
import Alamofire

class NetworkingHelper {
    let headers: HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    private let baseUrl = "https://medico-backend-2vci.onrender.com"
    static let shared = NetworkingHelper()
    
    private init() {}
    
    func configUrl(endpoint: String) -> String {
        baseUrl + endpoint
    }
}
