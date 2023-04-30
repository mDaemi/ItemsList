//
//  Constants.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 30/04/2023.
//

import Foundation

struct Constants {
    struct api {
        static let base = "raw.githubusercontent.com/leboncoin/paperclip/master"
        static let items = "/listing.json"
        static let categories = "/categories.json"
        
        enum urls {
            case items
            case categories
        }
    }
}

extension Constants {
    static func getConfigUrl(_ url: Constants.api.urls) -> String {
        var key: String = ""
        
        switch url {
        case .items:
            key = api.items
        case .categories:
            key = api.categories
        }
        
        return "https://\(api.base)\(key)"
    }
}
