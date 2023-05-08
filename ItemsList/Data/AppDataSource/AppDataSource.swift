//
//  AppDataSource.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 01/05/2023.
//

import Foundation

class AppDataSource {
    // MARK: - Properties
    private let service = AppService()

    // MARK: - Public
    public func getItems() async throws -> [Item]? {
        let result = try await service.getItems().map {$0.map {$0.toDomain()}}
        return result
    }
    
    public func getCategories() async throws -> [ItemCategory]? {
        return try await service.getCategories().map {$0.map {$0.toDomain()}}
    }
}
