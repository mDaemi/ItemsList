//
//  AppService.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 01/05/2023.
//

import Foundation

final class AppService: AbstractService {
    
    // MARK: - Properties
    static let shared = AppService()

    // MARK: - public
    public func getItems() async throws -> [ItemResponse]? {
        let urlString = Constants.getUrlString(of: Constants.requests.items)
        guard let url = URL(string: urlString) else {
            throw AppError.ServiceError.invalidData
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = Constants.httpMethod.get
        if #available(iOS 15.0, *) {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let decoder = self.getDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode([ItemResponse].self, from: data)
        } else {
            return try await withCheckedThrowingContinuation({
                (continuation: CheckedContinuation<[ItemResponse]?, Error>) in
                getItems(urlRequest: urlRequest, completion: { data, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else {
                        continuation.resume(returning: data)
                    }
                })
            })
        }
    }
    
    public func getCategories() async throws -> [CategoryResponse]? {
        let urlString = Constants.getUrlString(of: Constants.requests.categories)
        guard let url = URL(string: urlString) else {
            throw AppError.ServiceError.invalidData
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = Constants.httpMethod.get
        if #available(iOS 15.0, *) {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            return try self.getDecoder().decode([CategoryResponse].self, from: data)
        } else {
            return try await withCheckedThrowingContinuation({
                (continuation: CheckedContinuation<[CategoryResponse]?, Error>) in
                getCategories(urlRequest: urlRequest, completion: { data, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else {
                        continuation.resume(returning: data)
                    }
                })
            })
        }
    }

    // MARK: - Private
    private func getItems(urlRequest: URLRequest, completion: @escaping ([ItemResponse]?, Error?) -> Void) {
        let urlSession = URLSession(configuration: .default).dataTask(with: urlRequest, completionHandler: {(data, _, error) -> Void in
            if let error = error {
                completion(nil, error)
            } else if let data = data {
                do {
                    let decoder = self.getDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    completion(try decoder.decode([ItemResponse].self, from: data), nil)
                } catch {
                    completion(nil, AppError.ServiceError.invalidData)
                }
            } else {
                completion(nil, AppError.ServiceError.invalidData)
            }
        })
        urlSession.resume()
    }
    
    private func getCategories(urlRequest: URLRequest, completion: @escaping ([CategoryResponse]?, Error?) -> Void) {
        let urlSession = URLSession(configuration: .default).dataTask(with: urlRequest, completionHandler: {(data, _, error) -> Void in
            if let error = error {
                completion(nil, error)
            } else if let data = data {
                do {
                    completion(try self.getDecoder().decode([CategoryResponse].self, from: data), nil)
                } catch {
                    completion(nil, AppError.ServiceError.invalidData)
                }
            } else {
                completion(nil, AppError.ServiceError.invalidData)
            }
        })
        urlSession.resume()
    }
}
