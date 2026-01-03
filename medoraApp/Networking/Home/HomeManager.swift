//
//  HomeManager.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 21.11.25.
//

import Foundation

class HomeManager: HomeUseCase {
    let adapter = NetworkingAdapter()
    
    // MARK: Category
    func getAllCategories(endpoint: HomeEndpoint, completion: @escaping ((CoreModel<[Category]>?, String?) -> Void)) {
        adapter.request(url: endpoint.path, model: [Category].self, completion:  completion)
    }
    
    // MARK: Doctor
    func getAllDoctors(endpoint: HomeEndpoint, completion: @escaping ((CoreModel<[Doctor]>?, String?) -> Void)) {
        adapter.request(url: endpoint.path, model: [Doctor].self, completion:  completion)
    }
}
