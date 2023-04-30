//
//  Item.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 30/04/2023.
//

import Foundation

struct Item {
    let id: Int
    let category_id: Int
    let title: String
    let description: String
    let price: Double?
    let images_url: ImagesUrl?
    let creation_date: Date?
    let is_urgent: Bool
    let category_name: String
}
