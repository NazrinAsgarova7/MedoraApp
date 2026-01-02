//
//  HomeUseCase.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 21.11.25.
//

import Foundation

protocol HomeUseCase{
    func getAllCategories(endpoint: HomeEndpoint,completion: @escaping ((CoreModel<[Category]>?, String?) -> Void))
    func getAllDoctors(endpoint: HomeEndpoint, parameters: [String: String]? ,completion: @escaping ((CoreModel<[Doctor]>?, String?) -> Void))
}
