//
//  Constants.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 30/04/2023.
//

import Foundation

struct Constants {
    public typealias APIs = Constants.Service.API
    public typealias requests = Constants.Service.API.request
    public typealias httpMethod = Constants.Service.HttpMethod
    
    struct Service {
        struct API {
            static let base = "raw.githubusercontent.com/leboncoin/paperclip/master"
            static let items = "/listing.json"
            static let categories = "/categories.json"
            
            enum request {
                case items
                case categories
            }
        }
        
        struct HttpMethod {
            static let get = "GET"
            static let put = "PUT"
            static let post = "POST"
            static let delete = "DELETE"
        }
    }
}

extension Constants {
    static func getUrlString(of request: requests) -> String {
        var suffix: String = ""
        
        switch request {
        case .items:
            suffix = APIs.items
        case .categories:
            suffix = APIs.categories
        }
        
        return "https://\(APIs.base)\(suffix)"
    }
}
