//
//  DoctorViewModel.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 29.11.25.
//

import Foundation
import UIKit

class DoctorViewModel {
    enum ViewState {
        case success
        case error(error: String)
    }
    let manager = DoctorDetailManager()
    var doctorImage: UIImageView?
    var doctorDetail: DoctorResult?
    var completion: ((ViewState) -> Void)?
    var id: String
    
    init(doctorId: String) {
        id = doctorId
    }
    
    func getDoctorDetail() async {
        do {
            let result = try await manager.getDoctorDetail(endpoint: .getDetail(id: id), parameters: nil)
            doctorDetail = result?.data
            Task { @MainActor in
                completion?(.success)
            }
        } catch {
            Task { @MainActor in
                completion?(.error(error: error.localizedDescription))
            }
        }
    }
}
