//
//  ItemsListTests.swift
//  ItemsListTests
//
//  Created by MDA on 30/04/2023.
//

import XCTest
@testable import ItemsList

final class ItemsListTests: XCTestCase {
    // MARK: - Properties
    var viewModel: ItemsViewModel?
    var navigator: AppNavigatorMock?
    
    // MARK: - Inherite
    override func setUpWithError() throws {
        navigator = AppNavigatorMock(services: DataUseCaseProviderMock(), navigationController: UINavigationController())
        viewModel = ItemsViewModel(navigator!, DataUseCaseProviderMock().provideAppUseCase())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewModel_GetItems() {
        Task {
            do {
                try await viewModel?.fetchItems()
                XCTAssertTrue(viewModel?.items.count == 0)
            } catch {
                XCTFail()
            }
        }
    }
    
    func testViewModel_GetCategories() {
        Task {
            do {
                try await viewModel?.fetchCategories()
                XCTAssertTrue(viewModel?.categories.count == 0)
            } catch {
                XCTFail()
            }
        }
    }
    
    // Test navigation to the ItemDetails ViewController
    func testNavigator() throws {
        navigator?.toDetails(of: ItemUIModel(id: 1, title: "", description: "", price: "", creation_date: "", is_urgent: false, category_name: "", category_id: 1))
        guard (navigator?.pushedViewController as? ItemDetailViewController) != nil else {
            throw AppError.FunctionalError.general(message: "Unexpected Nil Error")
        }
    }
}
