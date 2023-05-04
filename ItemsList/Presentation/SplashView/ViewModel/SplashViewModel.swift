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
        self.navigator = AppNavigator(services: DataUseCaseProvider(), navigationController: UINavigationController())
    }
    
    // MARK: - Internal
    func toItems() {
        navigator.toItems()
    }
}
