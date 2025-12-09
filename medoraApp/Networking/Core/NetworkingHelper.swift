//
//  NetworkingHelper.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 13.11.25.
//

import Foundation
import Alamofire

class NetworkingHelper {
    
    static let shared = NetworkingHelper()
    private init() {}

    private let baseUrl = "https://medico-backend-2vci.onrender.com"
    let headers: HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    
    func configUrl(endpoint: String) -> String {
        baseUrl + endpoint
    }
    
    func hasInternet() async -> Bool {
        guard let url = URL(string: "https://www.google.com/generate_204") else { return false }
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 6)
        request.httpMethod = "HEAD"
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            return (response as? HTTPURLResponse)?.statusCode == 204
        } catch {
            return false
        }
    }
}
