//
//  medoraAppTests.swift
//  medoraAppTests
//
//  Created by Nazrin Asgarova on 06.01.26.
//

import XCTest
@testable import medoraApp

final class medoraAppTests: XCTestCase {
    private var mock: HomeMockManager!
    private var viewModel: HomeViewModel!
    
    override func setUp() {
        super.setUp()
        mock = HomeMockManager()
        viewModel = HomeViewModel(manager: mock)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCategoriesSuccessResult() throws {
        mock.categories = CoreModel(data: [
            .init(id: "1", name: "Cardio", icon: "sdf", createdAt: ""),
            .init(id: "2", name: "Cardio", icon: "sdf", createdAt: ""),
            .init(id: "3", name: "Cardio", icon: "sdf", createdAt: "")
        ])
        mock.error = nil
        var completionCalled = false
        
        viewModel.completion = { viewState in
            completionCalled = true
            switch viewState {
            case .success(isCategoryResponse: let bool):
                XCTAssertTrue(bool)
                XCTAssertEqual(self.viewModel.categories?.count, 3)
            case .error(let err):
                XCTFail("Expected success, got error: \(err)")
            }
        }
        viewModel.getCategories()
        XCTAssertTrue(completionCalled)
    }
    
    func testCategoriesErrorResult() throws {
        mock.categories = nil
        mock.error = "Server error"
        var completionCalled = false
        
        viewModel.completion = { viewState in
            completionCalled = true
            switch viewState {
            case .success:
                XCTFail("Expected error, got success")
                
            case .error(let err):
                XCTAssertEqual(err, "Server error")
            }
        }
        viewModel.getCategories()
        XCTAssertTrue(completionCalled)
        XCTAssertNil(viewModel.categories)
    }
    
    func testDoctorsSuccessResult() throws {
        mock.doctors = CoreModel(
            data: [
                .init(id: "1", name: "", specialization: "", photoURL: "", experienceYrs: 1, patientsCount: 1, feeCents: 1, ratingAverage: 1.0, ratingCount: 1, distanceM: 1, categoryID: "", availableSlots: ""),
                .init(id: "2", name: "", specialization: "", photoURL: "", experienceYrs: 1, patientsCount: 1, feeCents: 1, ratingAverage: 1.0, ratingCount: 1, distanceM: 1, categoryID: "", availableSlots: ""),
            ],
            pagination: .init(page: 1, totalPages: 3)
        )
        mock.error = nil
        var completionCalled = false
        
        viewModel.completion = { state in
            completionCalled = true
            switch state {
            case .success(isCategoryResponse: let isCategory):
                XCTAssertFalse(isCategory)
            case .error(let err):
                XCTFail("Expected success, got error: \(err)")
            }
        }
        viewModel.getAllDoctors()
        XCTAssertTrue(completionCalled)
        XCTAssertEqual(viewModel.doctors.count, 2)
        XCTAssertEqual(viewModel.data?.pagination?.page, 1)
    }
    
    func testDoctorsErrorResult() throws {
        mock.doctors = nil
        mock.error = "Timeout"
        
        var completionCalled = false
        
        viewModel.completion = { state in
            completionCalled = true
            switch state {
            case .success:
                XCTFail("Expected error, got success")
            case .error(let err):
                XCTAssertEqual(err, "Timeout")
            }
        }
        viewModel.getAllDoctors()
        
        XCTAssertTrue(completionCalled)
    }
    
    func testInternetError() {
        mock.doctors = nil
        mock.error = nil
        var completionCalled = false
        
        viewModel.completion = { state in
            completionCalled = true
            switch state {
            case .success:
                XCTFail("Expected internet error, got success")
            case .error(let err):
                XCTAssertEqual(err, "Internet Error")
            }
        }
        viewModel.getAllDoctors()
        XCTAssertTrue(completionCalled)
    }
}
