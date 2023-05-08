//
//  ItemResponse.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 30/04/2023.
//

import Foundation

struct ItemResponse: Decodable {
    var id: Int?
    var category_id: Int?
    var title: String?
    var description: String?
    var price: Double?
    var images_url: ImagesUrl?
    var creation_date: Date?
    var is_urgent: Bool?
}

struct ImagesUrl: Decodable {
    var small: String?
    var thumb: String?
}
