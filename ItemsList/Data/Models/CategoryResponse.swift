//
//  CategoryResponse.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 30/04/2023.
//

import Foundation

struct CategoriesResponse: Codable {
    let categories: [ItemResponse]?
}

struct CategoryResponse: Codable {
    var id: Int?
    var name: String?
}
