//
//  HomeUseCase.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 21.11.25.
//

import Foundation
import Alamofire

protocol HomeUseCase{
    func getAllCategories(endpoint: HomeEndpoint,completion: @escaping ((CoreModel<[Category]>?, String?) -> Void))
    func getAllDoctors(endpoint: HomeEndpoint, parameters: Parameters? ,completion: @escaping ((CoreModel<[Doctor]>?, String?) -> Void))
}
