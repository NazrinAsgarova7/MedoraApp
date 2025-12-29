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
    var reviews = [Review]()
    var completion: ((ViewState) -> Void)?
    var data: CoreModel<[Review]>?
    
    init(manager: ReviewUseCase, id: String) {
        self.manager = manager
        self.id = id
    }
    
    func getDoctorReviews() {
        let page = (data?.pagination?.page ?? 0) + 1
        manager.getReviews(endpoint: .getReviews(doctorId: id, page: page, limit: 10)) { [weak self] data, error in
            if let data {
                self?.data = data
                self?.reviews.append(contentsOf: data.data ?? [])
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
        
        manager.postReview(endpoint: .postReview(doctorId: id), parameters: parameters) { [weak self] data, error in
            if let data {
                self?.getDoctorReviews()
            } else if let error {
                self?.completion?(.error(error))
            } else {
                self?.completion?(.error("Internet Error"))
            }
        }
    }
    
    //MARK: Pagination
    func pagination(index: Int) {
        guard let page = data?.pagination?.page else { return }
        guard let totalPage = data?.pagination?.totalPages else { return }
        
        if index == reviews.count - 2 && page < totalPage {
            getDoctorReviews()
        }
    }
    
    func removeAllData() {
        data = nil
        reviews.removeAll()
    }
}
