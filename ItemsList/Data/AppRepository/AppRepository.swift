//
//  AppRepository.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 01/05/2023.
//

import Foundation

class AppRepository: PAppRepository {
    // MARK: - Properties
    static let shared = AppRepository()
    private let dataSource: AppDataSource = AppDataSource()
    
    // MARK: - public
    public func getItems() async throws -> [Item]? {
        return try await dataSource.getItems()
    }
    
    public func getCategories() async throws -> [ItemCategory]? {
        return try await dataSource.getCategories()
    }
}
