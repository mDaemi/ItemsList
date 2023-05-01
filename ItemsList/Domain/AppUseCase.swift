//
//  AppUseCase.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 01/05/2023.
//

import Foundation

class AppUseCase {
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
    
    func loadCategories() async throws -> [Category]? {
        return try await self.repository.getCategories()
    }
}
