//
//  AppService.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 01/05/2023.
//

import Foundation

class AppService: AbstractService {
    
    // MARK: - Properties
    static let shared = AppService()

    // MARK: - Public
    public func getItems() async throws -> ItemsListResponse? {
        var urlString = Constants.getUrlString(of: Constants.requests.items)
        guard let url = URL(string: urlString) else {
            throw AppError.ServiceError.invalidData
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = Constants.httpMethod.get
        if #available(iOS 15.0, *) {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            return try self.getDecoder().decode(ItemsListResponse.self, from: data)
        } else {
            return try await withCheckedThrowingContinuation({
                (continuation: CheckedContinuation<ItemsListResponse?, Error>) in
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
    
    public func getCategories() async throws -> CategoriesResponse? {
        var urlString = Constants.getUrlString(of: Constants.requests.categories)
        guard let url = URL(string: urlString) else {
            throw AppError.ServiceError.invalidData
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = Constants.httpMethod.get
        if #available(iOS 15.0, *) {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            return try self.getDecoder().decode(CategoriesResponse.self, from: data)
        } else {
            return try await withCheckedThrowingContinuation({
                (continuation: CheckedContinuation<CategoriesResponse?, Error>) in
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
    private func getItems(urlRequest: URLRequest, completion: @escaping (ItemsListResponse?, Error?) -> Void) {
        let urlSession = URLSession(configuration: .default).dataTask(with: urlRequest, completionHandler: {(data, _, error) -> Void in
            if let error = error {
                completion(nil, error)
            } else if let data = data {
                do {
                    completion(try self.getDecoder().decode(ItemsListResponse.self, from: data), nil)
                } catch {
                    completion(nil, AppError.ServiceError.invalidData)
                }
            } else {
                completion(nil, AppError.ServiceError.invalidData)
            }
        })
        urlSession.resume()
    }
    
    private func getCategories(urlRequest: URLRequest, completion: @escaping (CategoriesResponse?, Error?) -> Void) {
        let urlSession = URLSession(configuration: .default).dataTask(with: urlRequest, completionHandler: {(data, _, error) -> Void in
            if let error = error {
                completion(nil, error)
            } else if let data = data {
                do {
                    completion(try self.getDecoder().decode(CategoriesResponse.self, from: data), nil)
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
