//
//  Category+Mapper.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 30/04/2023.
//

import Foundation

extension ItemCategory {
    func toPresentation() -> CategoryUIModel {
        return CategoryUIModel(name: self.name, id: self.id)
    }
}
