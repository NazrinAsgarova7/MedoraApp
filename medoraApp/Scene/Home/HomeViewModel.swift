//
//  HomeViewModel.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 15.11.25.
//

import Foundation

class HomeViewModel {
    enum ViewState {
        case success
        case error(String)
    }
    let manager: HomeUseCase
    var categories: [Category]?
    var doctors: [Doctor]?
    var completion: ((ViewState) -> Void)?
    var selectedCategoryId = -1
    
    init(manager: HomeUseCase = HomeManager()) {
        self.manager = manager
    }
    
   //MARK: Category
    func getCategories() {
        manager.getAllCategories(endpoint: .getAllCategory) { [weak self] data, error in
            if let data{
                self?.completion?(.success)
                self?.categories = data.data ?? []
            } else if let error {
                self?.completion?(.error(error))
            } else {
                self?.completion?(.error("Internet Error"))
            }
        }
    }
    //MARK: Doctors
    func getAllDoctors() {
        manager.getAllDoctors(endpoint: .doctor, parameters: nil) { [weak self] data, error in
            if let data {
                self?.completion?(.success)
                self?.doctors = data.data ?? []
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
                    self?.completion?(.success)
                    self?.doctors = data.data ?? []
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
                self?.completion?(.success)
            } else if let error {
                self?.completion?(.error(error))
            } else {
                self?.completion?(.error("Internet Error"))
            }
        }
    }
    
}
