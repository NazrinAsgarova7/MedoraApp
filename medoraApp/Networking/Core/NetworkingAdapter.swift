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
                             completion:  @escaping ((CoreModel<T>?, String?)-> Void)) {
        AF.request(url,
                   method: method,
                   parameters: parameters,
                   encoding: encoding, headers: header).validate(statusCode: 200..<300).responseDecodable(of: CoreModel<T>.self) { response in
            switch response.result {
            case .success(let data):
                completion(data, nil)
//                (response.response?.statusCode == 201 || response.response?.statusCode == 200)  ? completion(data, nil) : completion(nil, "Server error (\(response.response?.statusCode))")
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    func request<T: Codable, Y: Codable>(url: String,
                                         successModel: T.Type,
                                         errorModel: Y.Type,
                                         method: HTTPMethod,
                                         parameters: Parameters? = nil,
                                         encoding: ParameterEncoding = URLEncoding.default,
                                         header: HTTPHeaders? = NetworkingHelper.shared.headers,
                                         completion:  @escaping ((T?,Y?)-> Void)) {
        AF.request(url,
                   method: method,
                   parameters: parameters,
                   encoding: encoding, headers: header).responseData{ response in
            switch response.result {
            case .success(let data):
                if  (response.response?.statusCode == 201 || response.response?.statusCode == 200) {
                    do {
                        let decoded = try JSONDecoder().decode(T.self, from: data)
                        completion(decoded, nil)
                    } catch {
                        print("Decode xətası (success): \(error)")
                        completion(nil, nil)
                    }
                    
                } else {
                    if let data = response.data {
                        if let decodedError = try? JSONDecoder().decode(Y.self, from: data) {
                            completion(nil, decodedError)
                            return
                        }
                    }
                }
            case .failure(_):
                if let data = response.data {
                    if let decodedError = try? JSONDecoder().decode(Y.self, from: data) {
                        completion(nil, decodedError)
                        return
                    }
                }
            }
        }
    }
    
    func request<T: Codable>(url: String,
                             model: T.Type,
                             method: HTTPMethod,
                             parameters: Parameters? = nil,
                             encoding: ParameterEncoding = URLEncoding.default,
                             header: HTTPHeaders? = NetworkingHelper.shared.headers) async throws -> T? {
        return try await AF.request(url,
                                    method: method,
                                    parameters: parameters,
                                    encoding: encoding, headers: header).serializingDecodable( T.self).value
    }
}
