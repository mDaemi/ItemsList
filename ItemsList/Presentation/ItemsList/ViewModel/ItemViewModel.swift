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
    @Published var items: [ItemUIModel] = []
    @Published var categories: [CategoryUIModel] = []
    
    // MARK: - Init
    init(_ navigator: AppNavigator, _ useCase: AppUseCase) {
        self.navigator = navigator
        self.useCase = useCase
    }

    func fetchItems() async throws {
        items = try await useCase.loadItems().map {$0.map {$0.toPresentation()}} ?? []
    }
    
    func fetchCategories() async throws {
        categories = try await useCase.loadCategories().map {$0.map {$0.toPresentation()}} ?? []
        updateItems()
    }
    
    func updateItems() {
        var index = 0
        for item in items {
            if let category = categories.first (where:{ $0.id == item.category_id }) {
                items[index].category_name = category.name
                index = index + 1
            }
        }
    }
    
    func toItemDetail() {
        navigator.toItemDetail()
    }
}
