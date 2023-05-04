//
//  ItemsResponse+Mapper.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 30/04/2023.
//

import Foundation

extension ItemResponse {
    func toDomain() -> Item {
        return Item(id: self.id ?? -1,
                    category_id: self.category_id ?? -1,
                    title: self.title ?? "",
                    description: self.description ?? "",
                    price: self.price,
                    images_url: self.images_url,
                    creation_date: self.creation_date,
                    is_urgent: self.is_urgent ?? false)
    }
}
