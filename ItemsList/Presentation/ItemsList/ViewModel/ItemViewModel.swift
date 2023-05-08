//
//  ItemsViewModel.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 01/05/2023.
//

import Foundation
import Combine

public class ItemsViewModel {
    
    // MARK: - Properties
    private var navigator: AppNavigator
    private let useCase: AppUseCase
    var categoriesNames: [String] = []
    @Published var items: [ItemUIModel] = []
    @Published var categories: [CategoryUIModel] = [] {
        didSet {
            categoriesNames = categories.compactMap({ category in
                category.name
            })
            categoriesNames.append(localized("item.filter"))
        }
    }
    
    // MARK: - Init
    init(_ navigator: AppNavigator, _ useCase: AppUseCase) {
        self.navigator = navigator
        self.useCase = useCase
    }
    
    // MARK: - Internal
    public func fetchItems() async throws {
        var result = try await useCase.loadItems().map {$0.map {$0.toPresentation()}} ?? []
        result = result.sorted(by: { $0.creation_date.compare($1.creation_date) == .orderedDescending })
        result.sort { $0.is_urgent && !$1.is_urgent }
        items = result
    }
    
    public func fetchCategories() async throws {
        categories = try await useCase.loadCategories().map {$0.map {$0.toPresentation()}} ?? []
        updateItems()
    }
    
    public func updateItems() {
        var index = 0
        for item in items {
            if let category = categories.first (where:{ $0.id == item.category_id }) {
                items[index].category_name = category.name
                index = index + 1
            }
        }
    }
    
    func toDetails(of item: ItemUIModel) {
        navigator.toDetails(of: item)
    }
}
