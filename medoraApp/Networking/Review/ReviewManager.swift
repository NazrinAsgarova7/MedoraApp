//
//  ReviewManager.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 04.12.25.
//

import Foundation
import Alamofire

class ReviewManager: ReviewUseCase {
    let adapter = NetworkingAdapter()
    
    func getReviews(endpoint: ReviewEndpoint, completion: @escaping ((CoreModel<Review>?, String?) -> Void)) {
        adapter.request(url: endpoint.path, model: Review.self, method: .get, completion: completion)
    }
}
