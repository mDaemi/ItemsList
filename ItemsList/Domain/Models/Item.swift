//
//  Item.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 30/04/2023.
//

import Foundation

public struct Item {
    let id: Int
    let category_id: Int
    let title: String
    let description: String
    var price: Double?
    var images_url: ImagesUrl?
    var creation_date: Date?
    let is_urgent: Bool
}
