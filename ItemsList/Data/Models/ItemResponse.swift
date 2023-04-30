//
//  ItemResponse.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 30/04/2023.
//

import Foundation

struct ItemsListResponse: Codable {
    let items: [ItemResponse]?
}

struct ItemResponse: Codable {
    var id: Int?
    var category_id: Int?
    var title: String?
    var description: String?
    var price: Double?
    var images_url: String?
    var creation_date: Date?
    var is_urgent: Bool?
    var category_name: String?
}
