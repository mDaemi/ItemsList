//
//  ItemUIModel.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 30/04/2023.
//

import Foundation

public struct ItemUIModel: Equatable {
    public static func == (lhs: ItemUIModel, rhs: ItemUIModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: Int
    let title: String
    let description: String
    var price: String
    var images_url: ImagesUrl?
    var creation_date: String
    let is_urgent: Bool
    var category_name: String
    let category_id: Int
}
