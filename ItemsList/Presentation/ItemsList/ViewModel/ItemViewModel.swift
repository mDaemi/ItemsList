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
    }
    
    func toItemDetail() {
        navigator.toItemDetail()
    }
}
