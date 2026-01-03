//
//  ReviewManager.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 04.12.25.
//

import Foundation

class ReviewManager: ReviewUseCase {
    let adapter = NetworkingAdapter()
    
    func getReviews(endpoint: ReviewEndpoint, completion: @escaping ((CoreModel<[Review]>?, String?) -> Void)) {
        adapter.request(url: endpoint.path, model: [Review].self, completion: completion)
    }
    
    func postReview(endpoint: ReviewEndpoint, parameters: [String: Any], completion: @escaping ((CoreModel<Review>?, String?) -> Void)) {
        adapter.request(url: endpoint.path, model: Review.self, method: .post, parameters: parameters, encoding: .json, completion: completion)
    }
}
