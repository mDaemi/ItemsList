//
//  AppServiceMock.swift
//  ItemsListTests
//
//  Created by Maedeh DAEMI on 07/05/2023.
//

import XCTest
@testable import ItemsList

class ModelTest: XCTestCase {
    var viewModel: ItemsViewModel?
    override func setUpWithError() throws {
        let navigator = AppNavigator(services: DataUseCaseProviderMock(), navigationController: UINavigationController())
        self.viewModel = ItemsViewModel(navigator, DataUseCaseProvider().provideAppUseCase())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewModel() {
        let expectation = XCTestExpectation(description: #function)
        Task {
            do {
                let result: ()? = try await viewModel?.fetchItems()
                expectation.fulfill()
//                XCTAssertEqual(result[0].first, ItemUIModel(id: 1, title: "test", description: "test", price: "test", creation_date: "01/01/01", is_urgent: true, category_name: "test", category_id: 1))
            } catch {
                XCTFail()
            }
        }
        
//        initialViewModel?.fetchData(completion: {result in
//            switch result {
//            case .failure:
//                XCTFail()
//            case .success(let data):
//                expectation.fulfill()
//                XCTAssertEqual(data[0].dataString, "The Test Data")
//            }
//        })
//        wait(for: [expectation], timeout: 3.0)
    }

}
