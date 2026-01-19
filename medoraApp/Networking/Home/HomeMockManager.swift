//
//  HomeMockManager.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 07.01.26.
//

import Foundation

final class HomeMockManager: HomeUseCase {
    var categories: CoreModel<[Category]>?
    var doctors: CoreModel<[Doctor]>?
    var error: String?
    
    func getAllCategories(endpoint: HomeEndpoint, completion: @escaping (CoreModel<[Category]>?, String?) -> Void) {
        completion(categories, error)
    }
    
    func getAllDoctors(endpoint: HomeEndpoint, completion: @escaping (CoreModel<[Doctor]>?, String?) -> Void) {
        completion(doctors, error)
    }
}
