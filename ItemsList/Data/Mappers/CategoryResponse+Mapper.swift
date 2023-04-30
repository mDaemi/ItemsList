//
//  CategoryResponse+Mapper.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 30/04/2023.
//

import Foundation

extension CategoryResponse {
    func toDomain() -> Category {
        return Category(id: self.id ?? -1,
                        name: self.name ?? "")
    }
}
