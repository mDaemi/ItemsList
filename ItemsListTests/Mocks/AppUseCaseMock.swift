//
//  AppUseCaseMock.swift
//  ItemsListTests
//
//  Created by Maedeh DAEMI on 08/05/2023.
//

import Foundation
@testable import ItemsList

class AppUseCaseMock {
    // MARK: - properties
    let repository: PAppRepository
    
    // MARK: - init
    init(repository: PAppRepository) {
        self.repository = repository
    }
    
    // MARK: - Internals
    func loadItems() async throws -> [Item]? {
        return try await self.repository.getItems()
    }
    
    func loadItemsError() async throws -> [Item]? {
        throw AppError.ServiceError.invalidData
    }
    
    func loadCategories() async throws -> [ItemCategory]? {
        return try await self.repository.getCategories()
    }
    
    func loadCategoriesError() async throws -> [ItemCategory]? {
        throw AppError.ServiceError.invalidData
    }
}
