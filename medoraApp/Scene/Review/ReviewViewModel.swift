//
//  ReviewViewModel.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 04.12.25.
//

import Foundation

class ReviewViewModel {
    enum ViewState {
        case success, error(String)
    }
    
    let manager: ReviewUseCase
    let id: String
    var reviews: [Review]?
    var completion: ((ViewState) -> Void)?
    
    init(manager: ReviewUseCase, id: String) {
        self.manager = manager
        self.id = id
    }
    
    func getDoctorReviews() {
        manager.getReviews(endpoint: .getReviews(doctorId: id)) { [weak self] data, error in
            if let data {
                self?.reviews = data.data
                self?.completion?(.success)

            } else if let error {
                self?.completion?(.error(error))
            }
        }
    }
    
    func postReview(rate: Int, comment: String) {
        let parameters: [String: Any] = [
            "rating": rate,
            "comment": comment,
            "userId": UserDefaultManager.shared.getData(key: .id)
        ]
        
        manager.postReview(endpoint: .getReviews(doctorId: id), parameters: parameters) { [weak self] data, error in
            if let data {
                self?.getDoctorReviews()
             //   self?.completion?(.success)
            } else if let error {
                self?.completion?(.error(error))
            }
        }
    }
}
