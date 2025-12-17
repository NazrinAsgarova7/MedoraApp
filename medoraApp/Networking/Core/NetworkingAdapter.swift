//
//  NetworkingManager.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 13.11.25.
//

import Foundation
import Alamofire

enum Encoding {
    case url, json
}

class NetworkingAdapter {
    func request<T: Codable>(url: String,
                             model: T.Type,
                             method: HTTPMethod,
                             parameters: Parameters? = nil,
                             encoding: Encoding = .url,
                             header: HTTPHeaders? = NetworkingHelper.shared.headers,
                             completion:  @escaping ((CoreModel<T>?, String?)-> Void)) {
        if !NetworkMonitor.shared.isConnected {
            completion(nil, nil)
            return
        }
        
        AF.request(url,
                   method: method,
                   parameters: parameters,
                   encoding: encoding == .url ? URLEncoding.default : JSONEncoding.default, headers: header).validate(statusCode: 200..<300).responseDecodable(of: CoreModel<T>.self) { response in
            switch response.result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    func request<T: Codable, Y: Codable>(url: String,
                                         successModel: T.Type,
                                         errorModel: Y.Type?,
                                         method: HTTPMethod,
                                         parameters: Parameters? = nil,
                                         encoding: Encoding = .url,
                                         header: HTTPHeaders? = NetworkingHelper.shared.headers,
                                         completion:  @escaping ((T?,Y?)-> Void)) {
        if !NetworkMonitor.shared.isConnected {
            print("Internet yoxdur")
            completion(nil, nil)
            return
        }
        AF.request(url,
                   method: method,
                   parameters: parameters,
                   encoding: encoding == .url ? URLEncoding.default : JSONEncoding.default, headers: header).responseData{ response in
            switch response.result {
            case .success(let data):
                if  (response.response?.statusCode == 201 || response.response?.statusCode == 200) {
                    do {
                        let decoded = try JSONDecoder().decode(T.self, from: data)
                        completion(decoded, nil)
                    } catch {
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
                             encoding: Encoding = .url,
                             header: HTTPHeaders? = NetworkingHelper.shared.headers) async throws -> CoreModel<T>?{
        if !NetworkMonitor.shared.isConnected {
            print("Internet yoxdur")
            return nil
        }
        return try await AF.request(url,
                                    method: method,
                                    parameters: parameters,
                                    encoding: encoding == .url ? URLEncoding.default : JSONEncoding.default, headers: header)
.serializingDecodable(CoreModel<T>.self).value
    }
    
}
