//
//  SplashNavigator.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 04/05/2023.
//

import UIKit

protocol PAppNavigator {
    func toItems()
    func toItemDetail()
}

class AppNavigator: AbstractNavigator, PAppNavigator {
    // MARK: - Internal
    func toItems() {
        let vc = ItemsListViewController()
        vc.viewModel = ItemsViewModel(self, DataUseCaseProvider().provideAppUseCase())
        navigationController.pushViewController(vc, animated: true)
//        getWindow()?.rootViewController = vc
//
//        let vc = ItemListViewController()
//        let navigationVC = UINavigationController(rootViewController: vc)
//        window?.rootViewController = navigationVC
        
    }
    
    func toItemDetail() {
        let vc = ItemDetailViewController()
        navigationController.pushViewController(vc, animated: true)
    }
    
    // MARK: - Private
    private func getWindow() -> UIWindow? {
        return UIApplication.shared.windows.first
    }
}
