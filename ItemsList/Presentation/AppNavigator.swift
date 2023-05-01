//
//  AppNavigator.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 01/05/2023.
//

import UIKit

protocol PAppNavigator {
    func toItemDetail()
}

final class AppNavigator: AbstractNavigator, PAppNavigator {
    func toItemDetail() {
        let vc = ItemDetailViewController()
        navigationController.pushViewController(vc, animated: true)
    }
}
