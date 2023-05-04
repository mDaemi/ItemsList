//
//  ItemsViewModel.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 01/05/2023.
//

import Foundation
import Combine

final class ItemsViewModel {
    
    // MARK: - Properties
    private var navigator: AppNavigator
    private let useCase: AppUseCase
    @Published private(set) var items: [ItemUIModel] = []

    
    // MARK: - Init
    init(_ navigator: AppNavigator, _ useCase: AppUseCase) {
        self.navigator = navigator
        self.useCase = useCase
    }

    func fetchItems() async -> Future<[ItemUIModel], Error> {
        do {
            let result = try await useCase.loadItems().map {$0.map {$0.toPresentation()}} ?? []
            return Future { promixe in
                promixe(.success(result))
            }
        } catch {
            return Future { promixe in
                promixe(.failure(error))
            }
        }
    }
    
    func getCategories() async throws -> [CategoryUIModel] {
        return try await useCase.loadCategories().map {$0.map {$0.toPresentation()}} ?? []
    }
    
    func toItemDetail() {
        navigator.toItemDetail()
    }
}
