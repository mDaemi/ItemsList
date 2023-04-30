//
//  AbstractService.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 30/04/2023.
//

import Foundation

class AbstractService {
    internal let rootUrl: String

    // MARK: - Properties
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }()
    
    init(rootUrl: String) {
        self.rootUrl = rootUrl
    }
    
    // MARK: - Public
    func getDecoder() -> JSONDecoder {
        return decoder
    }
    
    func getRootUrl() -> String {
        return rootUrl
    }
}
