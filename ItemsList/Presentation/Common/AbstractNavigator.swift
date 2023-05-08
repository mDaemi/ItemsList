//
//  AbstractNavigator.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 01/05/2023.
//

import UIKit

public class AbstractNavigator {
    // MARK: - Properties
    internal let navigationController: UINavigationController
    internal let services: UseCaseProvider

    // MARK: - Init
    init(services: UseCaseProvider,
         navigationController: UINavigationController) {
        self.services = services
        self.navigationController = navigationController
    }
}
