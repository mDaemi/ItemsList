//
//  AppRepository.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 01/05/2023.
//

import Foundation

class AppRepository: PAppRepository {
    private let dataSource: AppDataSource = AppDataSource()
    func getItems() async throws -> [Item]? {
        return try await dataSource.getItems()
    }
    
    func getCategories() async throws -> [Category]? {
        return try await dataSource.getCategories()
    }
}
