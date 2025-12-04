//
//  ReviewUseCase.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 04.12.25.
//

import Foundation

protocol ReviewUseCase {
    func getReviews(endpoint: ReviewEndpoint, completion: @escaping ((CoreModel<Review>?, String?) -> Void))
}
