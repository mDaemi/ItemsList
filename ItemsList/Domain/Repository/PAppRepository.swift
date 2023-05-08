//
//  File.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 01/05/2023.
//

import Foundation

protocol PAppRepository {
    func getItems() async throws -> [Item]?
    func getCategories() async throws -> [ItemCategory]?
}
