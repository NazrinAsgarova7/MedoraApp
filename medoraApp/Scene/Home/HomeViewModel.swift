//
//  HomeViewModel.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 15.11.25.
//

import Foundation

class HomeViewModel {
    enum ViewState {
        case success(isCategoryResponse: Bool)
        case error(String)
    }
    let manager: HomeUseCase
    var categories: [Category]?
    var doctors = [Doctor]()
    var completion: ((ViewState) -> Void)?
    var data: CoreModel<[Doctor]>?
    
    var selectedCategoryId = -1
    
    init(manager: HomeUseCase = HomeManager()) {
        self.manager = manager
    }
    
   //MARK: Category
    func getCategories() {
        manager.getAllCategories(endpoint: .getAllCategory) { [weak self] data, error in
            if let data {
                self?.categories = data.data ?? []
                self?.completion?(.success(isCategoryResponse: true))
            } else if let error {
                self?.completion?(.error(error))
            } else {
                self?.completion?(.error("Internet Error"))
            }
        }
    }
    //MARK: Doctors
    func getAllDoctors() {
        let page = (data?.pagination?.page ?? 0) + 1
        manager.getAllDoctors(endpoint: .doctor(page: page, limit: 6), parameters: nil) { [weak self] data, error in
            if let data {
                self?.data = data
                self?.doctors.append(contentsOf: data.data ?? [])
                self?.completion?(.success(isCategoryResponse: false))
            } else if let error {
                self?.completion?(.error(error))
            } else {
                self?.completion?(.error("Internet Error"))
            }
        }
    }
    
    func getDoctorByCategoryId(id: String, index: Int) {
        if index == selectedCategoryId {
            selectedCategoryId = -1
            getAllDoctors()
        } else {
            selectedCategoryId = index
            manager.getAllDoctors(endpoint: .getDoctorByCategoryId(id: id), parameters: nil) { [weak self] data, error in
                if let data {
                    self?.doctors = data.data ?? []
                    self?.completion?(.success(isCategoryResponse: false))
                } else if let error {
                    self?.completion?(.error(error))
                } else {
                    self?.completion?(.error("Internet Error"))
                }
            }
        }
        
    }
    
    //MARK: Search
    func search(query: String) {
        manager.getAllDoctors(endpoint: .search(query: query), parameters: nil) { [weak self] data, error in
            if let data {
                self?.doctors = data.data ?? []
                self?.completion?(.success(isCategoryResponse: false))
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
        
        if index == doctors.count - 2 && page < totalPage {
            getAllDoctors()
        }
    }
    
    func removeAllData() {
        data = nil
        doctors.removeAll()
    }
}
