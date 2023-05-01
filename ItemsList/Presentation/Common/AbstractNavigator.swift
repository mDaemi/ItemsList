//
//  AbstractNavigator.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 01/05/2023.
//

import UIKit

class AbstractNavigator {
    internal let navigationController: UINavigationController
    internal let services: UseCaseProvider

    init(services: UseCaseProvider,
         navigationController: UINavigationController) {
        self.services = services
        self.navigationController = navigationController
    }
}
