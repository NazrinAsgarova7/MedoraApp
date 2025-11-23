//
//  HomeManager.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 21.11.25.
//

import Foundation
import Alamofire

class HomeManager: HomeUseCase {
    let adapter = NetworkingAdapter()
    
    // MARK: Category
    func getAllCategories(endpoint: HomeEndpoint, parameters: Parameters? ,completion: @escaping ((CoreModel<Category>?, String?) -> Void)) {
        adapter.request(url: endpoint.path, model: Category.self, method: .get, parameters: parameters, encoding: JSONEncoding.default, completion:  completion)
    }
    
    // MARK: Doctor
    func getAllDoctors(endpoint: HomeEndpoint, parameters: Parameters? ,completion: @escaping ((CoreModel<Doctor>?, String?) -> Void)) {
        adapter.request(url: endpoint.path, model: Doctor.self, method: .get, parameters: parameters, encoding: JSONEncoding.default, completion:  completion)
    }
}
