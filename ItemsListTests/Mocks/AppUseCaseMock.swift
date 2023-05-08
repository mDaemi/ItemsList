//
//  AppUseCaseMock.swift
//  ItemsListTests
//
//  Created by Maedeh DAEMI on 08/05/2023.
//

import Foundation
@testable import ItemsList

class AppUseCaseMock: PAppUseCase {
    // MARK: - properties
    let repository: PAppRepository
    
    // MARK: - init
    init(repository: PAppRepository) {
        self.repository = repository
    }
    
    // MARK: - Internals
    func loadItems() async throws -> [Item]? {
        // Test error
        // throw AppError.ServiceError.invalidData
        
        // Test call
        return []
    }
    
    func loadCategories() async throws -> [ItemCategory]? {
        // Test error
        // throw AppError.ServiceError.invalidData
        
        // Test call
         return []
    }
}
