//
//  ItemsViewModel.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 01/05/2023.
//

import Foundation

final class ItemsViewModel {
    // MARK: - Properties
    private var navigator: AppNavigator
    private let useCase: AppUseCase
    
    // MARK: - Init
    init(_ navigator: AppNavigator, _ useCase: AppUseCase) {
        self.navigator = navigator
        self.useCase = useCase
    }
    
    // MARK: - Public
    func getItems() async throws -> [ItemUIModel] {
        return try await useCase.loadItems().map {$0.map {$0.toPresentation()}} ?? []
    }
    
    func getCategories() async throws -> [CategoryUIModel] {
        return try await useCase.loadCategories().map {$0.map {$0.toPresentation()}} ?? []
    }
    
    func toItemDetail() {
        navigator.toItemDetail()
    }
}
