//
//  SplashViewModel.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 04/05/2023.
//

import Foundation
import UIKit

final class SplashViewModel {
    // MARK: - Properties
    private var navigator: AppNavigator
    
    // MARK: - Init
    init() {
        if let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }), let navigationController = keyWindow.rootViewController as? UINavigationController {
            self.navigator = AppNavigator(services: DataUseCaseProvider(), navigationController: navigationController)
        } else {
            self.navigator = AppNavigator(services: DataUseCaseProvider(), navigationController: UINavigationController())
        }
    }
    
    // MARK: - Internal
    func toItems() {
        navigator.toItems()
    }
}
