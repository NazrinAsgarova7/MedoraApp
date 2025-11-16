//
//  NetworkingManager.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 13.11.25.
//

import Foundation
import Alamofire

class NetworkingAdapter {
    func request<T: Codable>(url: String,
                             model: T.Type,
                             method: HTTPMethod,
                             parameters: Parameters? = nil,
                             encoding: ParameterEncoding = URLEncoding.default,
                             header: HTTPHeaders? = NetworkingHelper.shared.headers,
                             completion:  @escaping ((T?,String?)-> Void)) {
        AF.request(url,
                   method: method,
                   parameters: parameters,
                   encoding: encoding, headers: header).responseDecodable(of: T.self) { response in
            if let data = response.data {
                    print("RAW BODY:", String(data: data, encoding: .utf8) ?? "no utf8")
                }
            switch response.result {
            case .success(let data):
                (response.response?.statusCode == 201 || response.response?.statusCode == 200)  ? completion(data, nil) : completion(nil, "Server error (\(response.response?.statusCode))")
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
}
