//
//  SplashNavigator.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 04/05/2023.
//

import UIKit

protocol PAppNavigator {
    func toItems()
    func toDetails(of item: ItemUIModel)
}

class AppNavigator: AbstractNavigator, PAppNavigator {
    // MARK: - Internal
    func toItems() {
        let vc = ItemsListViewController()
        vc.viewModel = ItemsViewModel(self, DataUseCaseProvider().provideAppUseCase())
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toDetails(of item: ItemUIModel) {
        let vc = ItemDetailViewController(item)
        navigationController.pushViewController(vc, animated: true)
    }
    
    // MARK: - Private
    private func getWindow() -> UIWindow? {
        return UIApplication.shared.windows.first
    }
}
