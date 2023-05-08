//
//  UINavigationControllerMock.swift
//  ItemsListTests
//
//  Created by Maedeh DAEMI on 08/05/2023.
//

import UIKit
@testable import ItemsList

class AppNavigatorMock : AppNavigator {
    var pushedViewController: UIViewController?
    
    public override func toItems() {
        super.toItems()
        pushedViewController = navigationController.viewControllers[navigationController.viewControllers.count - 1]
    }
    
    public override func toDetails(of item: ItemUIModel) {
        super.toDetails(of: item)
        pushedViewController = navigationController.viewControllers[navigationController.viewControllers.count - 1]
    }
}
