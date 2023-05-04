//
//  Item+Mapper.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 30/04/2023.
//

import Foundation

extension Item {
    func toPresentation() -> ItemUIModel {
        return ItemUIModel(title: self.title,
                           description: self.description,
                           price: (self.price == nil) ? "" : numberFormatter(on: self.price!),
                           images_url: self.images_url,
                           creation_date: (self.creation_date == nil) ? "" :
                            DateFormatter.europeanFormat.string(from: self.creation_date!),
                           is_urgent: self.is_urgent,
                           category_name: "",
                           category_id: self.category_id)
    }
    
    private func numberFormatter(on price: Double) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "es_ES")
        return currencyFormatter.string(from: NSNumber(value: price)) ?? ""
    }
}
